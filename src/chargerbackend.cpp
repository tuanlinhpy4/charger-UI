#include "chargerbackend.h"
#include <QtMath>
#include <QJsonObject>
#include <QJsonDocument>

// ══════════════════════════════════════════════
//  ChargerPort
// ══════════════════════════════════════════════

ChargerPort::ChargerPort(QObject *parent)
    : QObject(parent)
    , m_name("Port")
    , m_connector("CCS2")
    , m_maxPower(120)
{
    m_simTimer.setInterval(1000);
    connect(&m_simTimer, &QTimer::timeout, this, &ChargerPort::onSimTick);
}

ChargerPort::ChargerPort(const QString &name, const QString &connector,
                         int maxPower, QObject *parent)
    : QObject(parent)
    , m_name(name)
    , m_connector(connector)
    , m_maxPower(maxPower)
{
    m_simTimer.setInterval(1000);
    connect(&m_simTimer, &QTimer::timeout, this, &ChargerPort::onSimTick);
}

void ChargerPort::generateSessionId()
{
    int rand = QRandomGenerator::global()->bounded(1000000);
    m_sessionId = "EV" + QString::number(rand);
}

void ChargerPort::setConnector(const QString &conn)
{
    if (m_connector == conn) return;
    m_connector = conn;
    emit connectorChanged();
}

void ChargerPort::setPricing(const QVariantMap &config)
{
    m_pricingConfig = config;
    emit energyDeliveredChanged();
}

void ChargerPort::setState(int s)
{
    if (m_state == s) return;
    m_state = s;
    emit stateChanged();
}

bool ChargerPort::authenticate(int method, const QString &credential)
{
    Q_UNUSED(method)
    Q_UNUSED(credential)
    m_authenticated = true;
    emit authChanged();
    return true;
}

void ChargerPort::startCharging()
{
    if (m_state != Available && m_state != AwaitingAuth)
        return;

    generateSessionId();
    m_startSoc = 15.0 + (QRandomGenerator::global()->bounded(30));
    m_batteryPercent = m_startSoc;
    m_energyDelivered = 0.0;
    m_elapsedSeconds = 0;
    m_currentPower = m_maxPower * 0.9;
    m_authenticated = true;

    emit authChanged();
    emit stateChanged();
    emit batteryPercentChanged();
    emit energyDeliveredChanged();
    emit elapsedSecondsChanged();
    emit currentPowerChanged();
    emit sessionStarted(m_sessionId);

    m_simTimer.start();
}

void ChargerPort::stopCharging()
{
    if (m_state != Charging && m_state != Available && m_state != Finished)
        return;

    m_simTimer.stop();
    double savedPower = m_currentPower;
    m_currentPower = 0.0;
    emit currentPowerChanged();
    emitSessionEnd("Đã dừng");
    m_state = Available;
    m_authenticated = false;
    emit stateChanged();
    emit authChanged();
    Q_UNUSED(savedPower)
}

void ChargerPort::resetPort()
{
    m_simTimer.stop();
    m_currentPower = 0.0;
    m_batteryPercent = 0.0;
    m_startSoc = 0.0;
    m_energyDelivered = 0.0;
    m_elapsedSeconds = 0;
    m_authenticated = false;
    m_sessionId.clear();
    m_state = Available;

    emit stateChanged();
    emit batteryPercentChanged();
    emit energyDeliveredChanged();
    emit elapsedSecondsChanged();
    emit currentPowerChanged();
    emit authChanged();
}

void ChargerPort::emitSessionEnd(const QString &status)
{
    if (m_sessionId.isEmpty())
        return;
    emit sessionEnded(m_sessionId, m_energyDelivered, sessionCost(),
                      avgPower(), m_startSoc, m_batteryPercent,
                      status, m_elapsedSeconds, (double)m_maxPower);
}

void ChargerPort::onSimTick()
{
    if (m_state != Charging)
        return;

    m_elapsedSeconds++;
    emit elapsedSecondsChanged();

    double taper = 1.0;
    if (m_batteryPercent > 80.0)
        taper = qMax(0.2, 1.0 - (m_batteryPercent - 80.0) / 20.0);

    m_currentPower = m_maxPower * taper *
                     (0.85 + 0.15 * QRandomGenerator::global()->bounded(100) / 100.0);

    double dE = m_currentPower / 3600.0;
    m_energyDelivered += dE;
    emit energyDeliveredChanged();

    m_batteryPercent += (dE / 60.0) * 100.0;
    if (m_batteryPercent >= 100.0) {
        m_batteryPercent = 100.0;
        m_simTimer.stop();
        m_currentPower = 0.0;
        emitSessionEnd("Hoàn thành");
        m_state = Finished;
        emit stateChanged();
    }

    emit batteryPercentChanged();
    emit currentPowerChanged();
}

// ══════════════════════════════════════════════
//  OCPPManager
// ══════════════════════════════════════════════

OCPPManager::OCPPManager(QObject *parent)
    : QObject(parent)
{
    m_heartbeatTimer.setInterval(60000);
    connect(&m_heartbeatTimer, &QTimer::timeout, this, [this]() {
        if (m_connected) {
            qDebug() << "[OCPP] Heartbeat sent";
            emit connectionChanged();
        }
    });
    m_heartbeatTimer.start();

    m_reconnectTimer.setInterval(5000);
    connect(&m_reconnectTimer, &QTimer::timeout, this, [this]() {
        m_connected = true;
        m_reconnectAttempts = 0;
        m_reconnectTimer.stop();
        emit connectionChanged();
    });
}

void OCPPManager::simulateDisconnect()
{
    m_connected = false;
    m_reconnectTimer.start();
    emit connectionChanged();
}

void OCPPManager::reconnect()
{
    m_reconnectTimer.stop();
    m_connected = true;
    m_reconnectAttempts = 0;
    emit connectionChanged();
}

void OCPPManager::sendStatusNotification(int connectorId, const QString &status)
{
    QJsonObject notif;
    notif["connectorId"] = connectorId;
    notif["status"] = status;
    notif["timestamp"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    notif["chargeBoxId"] = m_chargeBoxId;
    qDebug() << "[OCPP] StatusNotification:" << QJsonDocument(notif).toJson();
}

void OCPPManager::sendMeterValues(int connectorId, double energy, double power)
{
    QJsonObject values;
    values["connectorId"] = connectorId;
    values["energy"] = energy;
    values["power"] = power;
    values["timestamp"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    emit meterValuesReceived(connectorId, values);
}

void OCPPManager::authorize(const QString &idTag)
{
    qDebug() << "[OCPP] Authorize:" << idTag;
    QTimer::singleShot(200, this, [this, idTag]() {
        emit authorizationResult(true, idTag);
    });
}

void OCPPManager::sendAuthorizeRequest(const QString &idTag)
{
    qDebug() << "[OCPP] AuthorizeRequest:" << idTag;
    QTimer::singleShot(300, this, [this, idTag]() {
        emit authorizationResult(true, idTag);
    });
}

void OCPPManager::sendStartTransaction(int connectorId)
{
    int txId = QRandomGenerator::global()->bounded(100000);
    qDebug() << "[OCPP] StartTransaction connector" << connectorId << "-> txId:" << txId;
    emit transactionStarted(connectorId, "TX" + QString::number(txId));
}

void OCPPManager::sendStopTransaction(int transactionId, int meterStop)
{
    Q_UNUSED(transactionId)
    Q_UNUSED(meterStop)
    qDebug() << "[OCPP] StopTransaction meterStop:" << meterStop;
    emit transactionStopped(transactionId);
}

// ══════════════════════════════════════════════
//  ChargerBackend
// ══════════════════════════════════════════════

ChargerBackend::ChargerBackend(QObject *parent)
    : QObject(parent)
{
    m_portA = new ChargerPort(QString::fromUtf8("Đầu sạc A"), "CCS2", 120, this);
    m_portB = new ChargerPort(QString::fromUtf8("Đầu sạc B"), "CCS2", 120, this);
    m_ocpp = new OCPPManager(this);

    connect(m_portA, &ChargerPort::sessionEnded, this,
            [this](const QString &sessionId, double energy, double cost,
                   double avgPower, double startSoc, double endSoc,
                   const QString &status, int duration, double maxPwr) {
                onPortSessionEnded(m_portA->name(), sessionId, energy, cost,
                                   avgPower, startSoc, endSoc, status,
                                   duration, maxPwr);
            });
    connect(m_portB, &ChargerPort::sessionEnded, this,
            [this](const QString &sessionId, double energy, double cost,
                   double avgPower, double startSoc, double endSoc,
                   const QString &status, int duration, double maxPwr) {
                onPortSessionEnded(m_portB->name(), sessionId, energy, cost,
                                   avgPower, startSoc, endSoc, status,
                                   duration, maxPwr);
            });

    connect(&m_clockTimer, &QTimer::timeout, this, &ChargerBackend::currentTimeChanged);
    m_clockTimer.start(1000);

    m_portA->startCharging();

    createDemoHistory();
}

void ChargerBackend::createDemoHistory()
{
    for (int i = 0; i < 6; i++) {
        SessionRecord *rec = new SessionRecord(
            "EV" + QString::number(802340 - i),
            QString::fromUtf8("Đầu sạc A"),
            "CCS2",
            18.0 + i * 5.0,
            900 + i * 120,
            68.0 + i * 0.5,
            30000.0 + (18.0 + i * 5.0) * 9500.0,
            i == 5 ? "Đã hủy" : "Hoàn thành",
            30.0 + i * 5,
            42.0 + i * 5,
            120.0,
            this
        );
        m_sessionHistory.append(rec);
    }

    double totalE = 0, totalR = 0;
    int totalS = 0;
    for (SessionRecord *r : m_sessionHistory) {
        totalE += r->energy();
        totalR += r->cost();
        totalS++;
    }
    m_totalEnergyToday = totalE;
    m_revenueToday = totalR;
    m_sessionsToday = totalS;
}

QString ChargerBackend::currentTime() const
{
    return QDateTime::currentDateTime().toString("HH:mm:ss");
}

QString ChargerBackend::currentDate() const
{
    return QDateTime::currentDateTime().toString("dd/MM/yyyy");
}

bool ChargerBackend::ocppConnected() const
{
    return m_ocpp->connected();
}

QVariantMap ChargerBackend::stationInfo() const
{
    QVariantMap info;
    info["brand"] = "GETECH";
    info["model"] = "EVSE-IMX93";
    info["firmware"] = "v2.4.1";
    info["serial"] = "NXP-2025-GT-001";
    info["display"] = "DY1212W-4856 (12.1\")";
    info["security"] = "EdgeLock SE050";
    info["meter"] = "NXP KM35x";
    info["nfc"] = "PN7160";
    info["wifi"] = "Murata IW612 (Wi-Fi 6)";
    info["kernel"] = "Linux 5.15";
    info["protocol"] = "ISO 15118-2";
    info["ocppVersion"] = "1.6J";
    info["maxPower"] = 240;
    return info;
}

QVariantList ChargerBackend::sessionHistory() const
{
    QVariantList list;
    for (SessionRecord *r : m_sessionHistory) {
        list.append(QVariant::fromValue(r));
    }
    return list;
}

QVariantList ChargerBackend::todayHistory() const
{
    QVariantList list;
    for (SessionRecord *r : m_sessionHistory) {
        list.append(QVariant::fromValue(r));
    }
    return list;
}

void ChargerBackend::stopCharging(const QString &port)
{
    ChargerPort *p = (port == "A") ? m_portA : m_portB;
    p->stopCharging();
}

void ChargerBackend::startChargingOnPort(const QString &port)
{
    ChargerPort *p = (port == "A") ? m_portA : m_portB;
    p->startCharging();
}

void ChargerBackend::authenticatePort(const QString &port, int method, const QString &cred)
{
    ChargerPort *p = (port == "A") ? m_portA : m_portB;
    p->authenticate(method, cred);
}

void ChargerBackend::onPortSessionEnded(const QString &portName, const QString &sessionId,
                                       double energy, double cost, double avgPower,
                                       double startSoc, double endSoc,
                                       const QString &status, int duration, double maxPwr)
{
    SessionRecord *rec = new SessionRecord(
        sessionId, portName, "CCS2",
        energy, duration, avgPower, cost,
        status, startSoc, endSoc, maxPwr,
        this
    );
    m_sessionHistory.insert(0, rec);

    m_totalEnergyToday += energy;
    m_sessionsToday++;
    m_revenueToday += cost;

    emit sessionHistoryChanged();
    emit ocppConnectedChanged();
}
