#include "chargerbackend.h"
#include <QtMath>
#include <QJsonObject>
#include <QJsonDocument>
#include <QCoreApplication>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QProcessEnvironment>
#include <QTextStream>
#include <QThread>
#include <QMetaObject>

#include <atomic>
#include <fstream>
#include <map>
#include <mutex>
#include <optional>
#include <thread>

#ifdef EV_CHARGER_ENABLE_LIBOCPP
#include <everest/logging.hpp>
#include <nlohmann/json.hpp>
#include <ocpp/common/support_older_cpp_versions.hpp>
#include <ocpp/v16/charge_point.hpp>
#endif

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
    m_state = Charging;

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

#ifndef EV_CHARGER_LIBOCPP_ROOT
#define EV_CHARGER_LIBOCPP_ROOT ""
#endif

#ifdef EV_CHARGER_ENABLE_LIBOCPP
namespace {
QString isoUtcNow()
{
    return QDateTime::currentDateTimeUtc().toString(Qt::ISODate);
}

bool ensureDirectory(const QString &path)
{
    QDir dir(path);
    return dir.exists() || dir.mkpath(".");
}

void ensureFile(const QString &path)
{
    QFileInfo info(path);
    ensureDirectory(info.absolutePath());
    if (!info.exists()) {
        QFile file(path);
        if (file.open(QIODevice::WriteOnly)) {
            file.close();
        }
    }
}

QString defaultDataDir()
{
    const QString path = QProcessEnvironment::systemEnvironment().value(
        "EV_CHARGER_OCPP_DATA_DIR", "/tmp/ev_charger_ocpp");
    ensureDirectory(path);
    ensureDirectory(path + "/logs");
    return path;
}

QString findLibOcppRoot()
{
    const QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    const QString envRoot = env.value("EV_CHARGER_LIBOCPP_ROOT");
    if (!envRoot.isEmpty() && QFileInfo::exists(envRoot + "/share/everest/modules/OCPP/config.json"))
        return envRoot;

    const QString appPrefix = QDir(QCoreApplication::applicationDirPath()).absoluteFilePath("..");
    if (QFileInfo::exists(appPrefix + "/share/everest/modules/OCPP/config.json"))
        return QDir(appPrefix).canonicalPath();

    const QString compiledRoot = QStringLiteral(EV_CHARGER_LIBOCPP_ROOT);
    if (!compiledRoot.isEmpty() &&
        QFileInfo::exists(compiledRoot + "/share/everest/modules/OCPP/config.json")) {
        return compiledRoot;
    }

    if (QFileInfo::exists("/usr/local/share/everest/modules/OCPP/config.json"))
        return "/usr/local";
    if (QFileInfo::exists("/usr/share/everest/modules/OCPP/config.json"))
        return "/usr";

    return compiledRoot;
}

ocpp::Measurement makeMeasurement(double energyWh, double powerKw)
{
    ocpp::Measurement measurement;
    measurement.power_meter.timestamp = isoUtcNow().toStdString();
    measurement.power_meter.energy_Wh_import.total = static_cast<float>(energyWh);

    ocpp::Power power;
    power.total = static_cast<float>(powerKw * 1000.0);
    measurement.power_meter.power_W.emplace(power);
    return measurement;
}

void writeJsonFileIfMissing(const QString &path)
{
    QFileInfo info(path);
    ensureDirectory(info.absolutePath());
    if (!info.exists()) {
        QFile file(path);
        if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
            file.write("{}\n");
            file.close();
        }
    }
}

ocpp::SecurityConfiguration createSecurityConfig(const QString &dataDir)
{
    const QString certRoot = dataDir + "/certs";
    const QString v2gCa = certRoot + "/ca/v2g/V2G_CA_BUNDLE.pem";
    const QString moCa = certRoot + "/ca/mo/MO_CA_BUNDLE.pem";
    const QString mfCa = certRoot + "/ca/mf/MF_CA_BUNDLE.pem";
    const QString csmsCa = certRoot + "/ca/csms/CSMS_CA_BUNDLE.pem";
    const QString csmsLeafDir = certRoot + "/client/csms";
    const QString csoLeafDir = certRoot + "/client/cso";

    ensureFile(v2gCa);
    ensureFile(moCa);
    ensureFile(mfCa);
    ensureFile(csmsCa);
    ensureDirectory(csmsLeafDir);
    ensureDirectory(csoLeafDir);

    ocpp::SecurityConfiguration secConfig;
    secConfig.csms_ca_bundle = fs::path(csmsCa.toStdString());
    secConfig.mf_ca_bundle = fs::path(mfCa.toStdString());
    secConfig.v2g_ca_bundle = fs::path(v2gCa.toStdString());
    secConfig.mo_ca_bundle = fs::path(moCa.toStdString());
    secConfig.csms_leaf_cert_directory = fs::path(csmsLeafDir.toStdString());
    secConfig.csms_leaf_key_directory = fs::path(csmsLeafDir.toStdString());
    secConfig.secc_leaf_cert_directory = fs::path(csoLeafDir.toStdString());
    secConfig.secc_leaf_key_directory = fs::path(csoLeafDir.toStdString());
    return secConfig;
}
} // namespace

class OCPPManager::LibOcppClient
{
public:
    explicit LibOcppClient(OCPPManager *owner) : m_owner(owner) {}

    ~LibOcppClient()
    {
        stop();
    }

    bool start(const QString &csmsUrl, const QString &chargeBoxId, int heartbeatInterval)
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_chargePoint)
            return true;

        try {
            const QString root = findLibOcppRoot();
            const fs::path sharePath = fs::path(root.toStdString()) / "share" / "everest" / "modules" / "OCPP";
            const fs::path configPath = sharePath / "config.json";
            if (!fs::exists(configPath)) {
                qWarning() << "[OCPP] libocpp config not found:" << QString::fromStdString(configPath.string());
                return false;
            }

            const QString dataDir = defaultDataDir();
            const QString userConfigPath = dataDir + "/user_config.json";
            const QString databasePath = dataDir + "/ocpp16.db";
            const QString messageLogPath = dataDir + "/logs";
            writeJsonFileIfMissing(userConfigPath);

            std::ifstream ifs(configPath.c_str());
            nlohmann::json config = nlohmann::json::parse(ifs);
            config["Internal"]["ChargePointId"] = chargeBoxId.toStdString();
            config["Internal"]["CentralSystemURI"] = csmsUrl.toStdString();
            config["Internal"]["ChargeBoxSerialNumber"] = chargeBoxId.toStdString();
            config["Internal"]["ChargePointModel"] = "EVSE-IMX93";
            config["Internal"]["ChargePointVendor"] = "GETECH";
            config["Internal"]["FirmwareVersion"] = "2.4.1";
            config["Internal"]["LogMessagesFormat"] = nlohmann::json::array();
            config["Core"]["HeartbeatInterval"] = heartbeatInterval;
            config["Core"]["MeterValueSampleInterval"] = 5;
            config["Core"]["NumberOfConnectors"] = 2;
            config["Core"]["ConnectorPhaseRotation"] = "0.RST,1.RST,2.RST";
            config["Security"]["SecurityProfile"] = 0;

            static std::once_flag loggingOnce;
            std::call_once(loggingOnce, [&sharePath]() {
                Everest::Logging::init((sharePath / "logging.ini").string(), "ev_charger_ui");
            });

            m_chargePoint = std::make_unique<ocpp::v16::ChargePoint>(
                config.dump(), sharePath, fs::path(userConfigPath.toStdString()),
                fs::path(databasePath.toStdString()), sharePath / "core_migrations",
                fs::path(messageLogPath.toStdString()), nullptr, createSecurityConfig(dataDir));

            registerCallbacks();
            m_chargePoint->on_max_power_offered(1, 120000);
            m_chargePoint->on_max_power_offered(2, 120000);

            const std::map<int, ocpp::v16::ChargePointStatus> statusMap = {
                {0, ocpp::v16::ChargePointStatus::Available},
                {1, ocpp::v16::ChargePointStatus::Available},
                {2, ocpp::v16::ChargePointStatus::Available},
            };
            const bool started = m_chargePoint->start(statusMap, ocpp::v16::BootReasonEnum::PowerUp);
            qInfo() << "[OCPP] libocpp start" << (started ? "ok" : "failed")
                    << "CSMS:" << csmsUrl << "ChargeBoxId:" << chargeBoxId;
            return started;
        } catch (const std::exception &e) {
            qWarning() << "[OCPP] libocpp start failed:" << e.what();
            m_chargePoint.reset();
            return false;
        }
    }

    void stop()
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (!m_chargePoint)
            return;
        try {
            m_chargePoint->stop();
        } catch (const std::exception &e) {
            qWarning() << "[OCPP] stop failed:" << e.what();
        }
        m_chargePoint.reset();
    }

    void disconnect()
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_chargePoint)
            m_chargePoint->disconnect_websocket();
    }

    void reconnect()
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_chargePoint)
            m_chargePoint->connect_websocket();
    }

    bool authorize(const QString &idTag)
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (!m_chargePoint)
            return false;

        try {
            const auto result = m_chargePoint->authorize_id_token(
                ocpp::CiString<20>(idTag.toStdString()));
            return result.id_tag_info.status == ocpp::v16::AuthorizationStatus::Accepted;
        } catch (const std::exception &e) {
            qWarning() << "[OCPP] Authorize failed:" << e.what();
            return false;
        }
    }

    void beginSession(int connectorId, const QString &sessionId, const QString &idTag, double meterStartWh)
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (!m_chargePoint)
            return;

        try {
            const std::string session = sessionId.toStdString();
            const std::string token = idTag.toStdString();
            m_chargePoint->on_session_started(connectorId, session, ocpp::SessionStartedReason::EVConnected,
                                              std::nullopt);
            m_chargePoint->on_meter_values(connectorId, makeMeasurement(meterStartWh, 0.0));
            m_chargePoint->on_transaction_started(connectorId, session, token, meterStartWh, std::nullopt,
                                                  ocpp::DateTime(), std::nullopt);
            m_chargePoint->on_resume_charging(connectorId);
        } catch (const std::exception &e) {
            qWarning() << "[OCPP] begin session failed:" << e.what();
        }
    }

    void endSession(int connectorId, const QString &sessionId, double meterStopWh, const QString &reason)
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (!m_chargePoint)
            return;

        try {
            const auto stopReason = reason.contains(QString::fromUtf8("Hoàn thành"))
                                        ? ocpp::v16::Reason::EVDisconnected
                                        : ocpp::v16::Reason::Local;
            const std::string session = sessionId.toStdString();
            m_chargePoint->on_transaction_stopped(connectorId, session, stopReason, ocpp::DateTime(),
                                                  static_cast<float>(meterStopWh), std::nullopt, std::nullopt);
            m_chargePoint->on_session_stopped(connectorId, session);
        } catch (const std::exception &e) {
            qWarning() << "[OCPP] end session failed:" << e.what();
        }
    }

    void updateMeter(int connectorId, double energyWh, double powerKw)
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (!m_chargePoint)
            return;

        try {
            m_chargePoint->on_meter_values(connectorId, makeMeasurement(energyWh, powerKw));
        } catch (const std::exception &e) {
            qWarning() << "[OCPP] meter update failed:" << e.what();
        }
    }

    void setAvailable(int connectorId)
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_chargePoint)
            m_chargePoint->on_enabled(connectorId);
    }

private:
    void registerCallbacks()
    {
        m_chargePoint->register_connection_state_changed_callback([this](bool connected) {
            if (!m_owner)
                return;
            QMetaObject::invokeMethod(m_owner, [owner = m_owner, connected]() {
                owner->setConnected(connected);
            }, Qt::QueuedConnection);
        });

        m_chargePoint->register_enable_evse_callback([](std::int32_t) { return true; });
        m_chargePoint->register_disable_evse_callback([](std::int32_t) { return true; });
        m_chargePoint->register_pause_charging_callback([](std::int32_t) { return true; });
        m_chargePoint->register_resume_charging_callback([](std::int32_t) { return true; });
        m_chargePoint->register_unlock_connector_callback([](std::int32_t) {
            return ocpp::v16::UnlockStatus::Unlocked;
        });
        m_chargePoint->register_stop_transaction_callback([this](std::int32_t connector, ocpp::v16::Reason) {
            if (m_owner) {
                QMetaObject::invokeMethod(m_owner, [owner = m_owner, connector]() {
                    emit owner->remoteStopRequested(connector);
                }, Qt::QueuedConnection);
            }
            return true;
        });
        m_chargePoint->register_transaction_updated_callback(
            [this](const std::int32_t connector, const std::string&, const std::int32_t transactionId,
                   const ocpp::v16::IdTagInfo&) {
                if (!m_owner)
                    return;
                QMetaObject::invokeMethod(m_owner, [owner = m_owner, connector, transactionId]() {
                    emit owner->transactionStarted(connector, "TX" + QString::number(transactionId));
                }, Qt::QueuedConnection);
            });
        m_chargePoint->register_transaction_stopped_callback(
            [this](const std::int32_t, const std::string&, const std::int32_t transactionId) {
                if (!m_owner)
                    return;
                QMetaObject::invokeMethod(m_owner, [owner = m_owner, transactionId]() {
                    emit owner->transactionStopped(transactionId);
                }, Qt::QueuedConnection);
            });
    }

    OCPPManager *m_owner = nullptr;
    std::mutex m_mutex;
    std::unique_ptr<ocpp::v16::ChargePoint> m_chargePoint;
};
#endif

OCPPManager::OCPPManager(QObject *parent)
    : QObject(parent)
{
    const QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    m_csmsUrl = env.value("EV_CHARGER_CSMS_URL", m_csmsUrl);
    m_chargeBoxId = env.value("EV_CHARGER_CHARGE_BOX_ID", m_chargeBoxId);

    m_heartbeatTimer.setInterval(m_heartbeatInterval * 1000);
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

#ifdef EV_CHARGER_ENABLE_LIBOCPP
    m_client = std::make_unique<LibOcppClient>(this);
    if (!m_client->start(m_csmsUrl, m_chargeBoxId, m_heartbeatInterval)) {
        setConnected(false);
    }
#else
    setConnected(true);
#endif
}

OCPPManager::~OCPPManager() = default;

void OCPPManager::setConnected(bool connected)
{
    if (m_connected == connected)
        return;
    m_connected = connected;
    emit connectionChanged();
}

QString OCPPManager::normalizedIdTag(const QString &idTag) const
{
    QString normalized = idTag.trimmed();
    if (normalized.isEmpty())
        normalized = "DEMO";
    if (normalized.size() > 20)
        normalized = normalized.left(20);
    return normalized;
}

void OCPPManager::simulateDisconnect()
{
#ifdef EV_CHARGER_ENABLE_LIBOCPP
    if (m_client)
        m_client->disconnect();
#endif
    setConnected(false);
    m_reconnectTimer.start();
}

void OCPPManager::reconnect()
{
    m_reconnectTimer.stop();
    m_reconnectAttempts = 0;
#ifdef EV_CHARGER_ENABLE_LIBOCPP
    if (m_client)
        m_client->reconnect();
#else
    setConnected(true);
#endif
}

void OCPPManager::sendStatusNotification(int connectorId, const QString &status)
{
    QJsonObject notif;
    notif["connectorId"] = connectorId;
    notif["status"] = status;
    notif["timestamp"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    notif["chargeBoxId"] = m_chargeBoxId;
    qDebug() << "[OCPP] StatusNotification:" << QJsonDocument(notif).toJson();
#ifdef EV_CHARGER_ENABLE_LIBOCPP
    if (m_client && status == "Available")
        m_client->setAvailable(connectorId);
#endif
}

void OCPPManager::sendMeterValues(int connectorId, double energy, double power)
{
    QJsonObject values;
    values["connectorId"] = connectorId;
    values["energy"] = energy;
    values["power"] = power;
    values["timestamp"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    emit meterValuesReceived(connectorId, values);
#ifdef EV_CHARGER_ENABLE_LIBOCPP
    if (m_client)
        m_client->updateMeter(connectorId, energy * 1000.0, power);
#endif
}

void OCPPManager::authorize(const QString &idTag)
{
    sendAuthorizeRequest(idTag);
}

void OCPPManager::sendAuthorizeRequest(const QString &idTag)
{
    const QString tag = normalizedIdTag(idTag);
    qDebug() << "[OCPP] AuthorizeRequest:" << tag;
#ifdef EV_CHARGER_ENABLE_LIBOCPP
    std::thread([this, tag]() {
        const bool accepted = m_client ? m_client->authorize(tag) : false;
        QMetaObject::invokeMethod(this, [this, accepted, tag]() {
            emit authorizationResult(accepted, tag);
        }, Qt::QueuedConnection);
    }).detach();
#else
    QTimer::singleShot(300, this, [this, tag]() {
        emit authorizationResult(true, tag);
    });
#endif
}

void OCPPManager::sendStartTransaction(int connectorId)
{
    int txId = QRandomGenerator::global()->bounded(100000);
    qDebug() << "[OCPP] StartTransaction connector" << connectorId << "-> txId:" << txId;
#ifdef EV_CHARGER_ENABLE_LIBOCPP
    beginChargingSession(connectorId, "EV" + QString::number(txId), "DEMO", 0.0);
#endif
    emit transactionStarted(connectorId, "TX" + QString::number(txId));
}

void OCPPManager::sendStopTransaction(int transactionId, int meterStop)
{
    Q_UNUSED(transactionId)
    Q_UNUSED(meterStop)
    qDebug() << "[OCPP] StopTransaction meterStop:" << meterStop;
    emit transactionStopped(transactionId);
}

void OCPPManager::beginChargingSession(int connectorId, const QString &sessionId,
                                       const QString &idTag, double meterStartWh)
{
    sendStatusNotification(connectorId, "Charging");
#ifdef EV_CHARGER_ENABLE_LIBOCPP
    if (m_client)
        m_client->beginSession(connectorId, sessionId, normalizedIdTag(idTag), meterStartWh);
#else
    Q_UNUSED(sessionId)
    Q_UNUSED(idTag)
    Q_UNUSED(meterStartWh)
#endif
}

void OCPPManager::endChargingSession(int connectorId, const QString &sessionId,
                                     double meterStopWh, const QString &reason)
{
#ifdef EV_CHARGER_ENABLE_LIBOCPP
    if (m_client)
        m_client->endSession(connectorId, sessionId, meterStopWh, reason);
#else
    Q_UNUSED(sessionId)
    Q_UNUSED(meterStopWh)
    Q_UNUSED(reason)
#endif
    sendStatusNotification(connectorId, "Available");
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

    connect(m_ocpp, &OCPPManager::connectionChanged,
            this, &ChargerBackend::ocppConnectedChanged);
    connect(m_ocpp, &OCPPManager::remoteStopRequested, this,
            [this](int connectorId) {
                if (connectorId == 1)
                    m_portA->stopCharging();
                else if (connectorId == 2)
                    m_portB->stopCharging();
            });

    connect(m_portA, &ChargerPort::sessionStarted, this,
            [this](const QString &sessionId) {
                m_ocpp->beginChargingSession(1, sessionId, "DEMO", 0.0);
            });
    connect(m_portB, &ChargerPort::sessionStarted, this,
            [this](const QString &sessionId) {
                m_ocpp->beginChargingSession(2, sessionId, "DEMO", 0.0);
            });

    connect(m_portA, &ChargerPort::energyDeliveredChanged, this, [this]() {
        if (m_portA->state() == ChargerPort::Charging && m_portA->elapsedSeconds() % 5 == 0)
            m_ocpp->sendMeterValues(1, m_portA->energyDelivered(), m_portA->currentPower());
    });
    connect(m_portB, &ChargerPort::energyDeliveredChanged, this, [this]() {
        if (m_portB->state() == ChargerPort::Charging && m_portB->elapsedSeconds() % 5 == 0)
            m_ocpp->sendMeterValues(2, m_portB->energyDelivered(), m_portB->currentPower());
    });

    connect(m_portA, &ChargerPort::sessionEnded, this,
            [this](const QString &sessionId, double energy, double cost,
                   double avgPower, double startSoc, double endSoc,
                   const QString &status, int duration, double maxPwr) {
                m_ocpp->endChargingSession(1, sessionId, energy * 1000.0, status);
                onPortSessionEnded(m_portA->name(), sessionId, energy, cost,
                                   avgPower, startSoc, endSoc, status,
                                   duration, maxPwr);
            });
    connect(m_portB, &ChargerPort::sessionEnded, this,
            [this](const QString &sessionId, double energy, double cost,
                   double avgPower, double startSoc, double endSoc,
                   const QString &status, int duration, double maxPwr) {
                m_ocpp->endChargingSession(2, sessionId, energy * 1000.0, status);
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
    m_ocpp->sendAuthorizeRequest(cred.isEmpty() ? QStringLiteral("DEMO") : cred);
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
