#ifndef CHARGERBACKEND_H
#define CHARGERBACKEND_H

#include <QObject>
#include <QTimer>
#include <QDateTime>
#include <QRandomGenerator>
#include <QJsonObject>
#include <QJsonArray>
#include <QVariantList>
#include <memory>

class SessionRecord : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString sessionId READ sessionId CONSTANT)
    Q_PROPERTY(QString portName READ portName CONSTANT)
    Q_PROPERTY(QString connector READ connector CONSTANT)
    Q_PROPERTY(QString timestamp READ timestamp CONSTANT)
    Q_PROPERTY(double energy READ energy CONSTANT)
    Q_PROPERTY(int duration READ duration CONSTANT)
    Q_PROPERTY(double avgPower READ avgPower CONSTANT)
    Q_PROPERTY(double cost READ cost CONSTANT)
    Q_PROPERTY(QString status READ status CONSTANT)
    Q_PROPERTY(double startSoc READ startSoc CONSTANT)
    Q_PROPERTY(double endSoc READ endSoc CONSTANT)
    Q_PROPERTY(double maxPower READ maxPower CONSTANT)

public:
    SessionRecord(const QString &id, const QString &port, const QString &conn,
                  double energy, int duration, double avgPwr, double cost,
                  const QString &status, double startSoc, double endSoc,
                  double maxPwr, QObject *parent = nullptr)
        : QObject(parent), m_id(id), m_port(port), m_conn(conn)
        , m_energy(energy), m_duration(duration), m_avgPower(avgPwr), m_cost(cost)
        , m_status(status), m_startSoc(startSoc), m_endSoc(endSoc), m_maxPower(maxPwr)
        , m_timestamp(QDateTime::currentDateTime().toString("dd/MM/yyyy HH:mm"))
    {}

    QString sessionId() const { return m_id; }
    QString portName() const { return m_port; }
    QString connector() const { return m_conn; }
    QString timestamp() const { return m_timestamp; }
    double energy() const { return m_energy; }
    int duration() const { return m_duration; }
    double avgPower() const { return m_avgPower; }
    double cost() const { return m_cost; }
    QString status() const { return m_status; }
    double startSoc() const { return m_startSoc; }
    double endSoc() const { return m_endSoc; }
    double maxPower() const { return m_maxPower; }

private:
    QString m_id, m_port, m_conn, m_status, m_timestamp;
    double m_energy = 0;
    int m_duration = 0;
    double m_avgPower = 0;
    double m_cost = 0;
    double m_startSoc = 0;
    double m_endSoc = 0;
    double m_maxPower = 120.0;
};

class ChargerPort : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QString connector READ connector NOTIFY connectorChanged)
    Q_PROPERTY(int maxPower READ maxPower CONSTANT)
    Q_PROPERTY(int state READ state NOTIFY stateChanged)
    Q_PROPERTY(double batteryPercent READ batteryPercent NOTIFY batteryPercentChanged)
    Q_PROPERTY(double startSoc READ startSoc NOTIFY batteryPercentChanged)
    Q_PROPERTY(double energyDelivered READ energyDelivered NOTIFY energyDeliveredChanged)
    Q_PROPERTY(int elapsedSeconds READ elapsedSeconds NOTIFY elapsedSecondsChanged)
    Q_PROPERTY(double currentPower READ currentPower NOTIFY currentPowerChanged)
    Q_PROPERTY(double avgPower READ avgPower NOTIFY energyDeliveredChanged)
    Q_PROPERTY(double sessionCost READ sessionCost NOTIFY energyDeliveredChanged)
    Q_PROPERTY(QString sessionId READ sessionId NOTIFY sessionStarted)
    Q_PROPERTY(bool authenticated READ authenticated NOTIFY authChanged)

public:
    enum State { Available = 0, Charging, Finished, Faulted, Locked, AwaitingAuth };
    Q_ENUM(State)

    enum AuthMethod { AppQR = 0, NFCRfid, PIN, PlugAndCharge };
    Q_ENUM(AuthMethod)

    explicit ChargerPort(QObject *parent = nullptr);
    ChargerPort(const QString &name, const QString &connector,
                int maxPower, QObject *parent = nullptr);
    ~ChargerPort() = default;

    QString name() const { return m_name; }
    QString connector() const { return m_connector; }
    int maxPower() const { return m_maxPower; }
    int state() const { return m_state; }
    double batteryPercent() const { return m_batteryPercent; }
    double startSoc() const { return m_startSoc; }
    double energyDelivered() const { return m_energyDelivered; }
    int elapsedSeconds() const { return m_elapsedSeconds; }
    double currentPower() const { return m_currentPower; }
    double avgPower() const {
        return m_elapsedSeconds > 0 ? m_energyDelivered / (m_elapsedSeconds / 3600.0) : 0.0;
    }
    double sessionCost() const {
        double ratePerKwh = m_pricingConfig.isEmpty() ? 9500.0 : m_pricingConfig["dcRate"].toDouble();
        double initFee = m_pricingConfig.isEmpty() ? 30000.0 : m_pricingConfig["initFee"].toDouble();
        return m_energyDelivered * ratePerKwh + initFee;
    }
    QString sessionId() const { return m_sessionId; }
    bool authenticated() const { return m_authenticated; }

    Q_INVOKABLE void startCharging();
    Q_INVOKABLE void stopCharging();
    Q_INVOKABLE void resetPort();
    Q_INVOKABLE bool authenticate(int method, const QString &credential = "");
    Q_INVOKABLE void setConnector(const QString &conn);
    Q_INVOKABLE void setPricing(const QVariantMap &config);
    Q_INVOKABLE void setState(int s);

signals:
    void stateChanged();
    void connectorChanged();
    void batteryPercentChanged();
    void energyDeliveredChanged();
    void elapsedSecondsChanged();
    void currentPowerChanged();
    void sessionStarted(const QString &sessionId);
    void sessionEnded(const QString &sessionId, double energy, double cost,
                      double avgPower, double startSoc, double endSoc,
                      const QString &status, int duration, double maxPwr);
    void authChanged();
    void faultOccurred(const QString &reason);

private slots:
    void onSimTick();

private:
    void generateSessionId();
    void emitSessionEnd(const QString &status);

    QString m_name;
    QString m_connector;
    int m_maxPower = 0;
    int m_state = Available;
    double m_batteryPercent = 0.0;
    double m_startSoc = 0.0;
    double m_energyDelivered = 0.0;
    int m_elapsedSeconds = 0;
    double m_currentPower = 0.0;
    QString m_sessionId;
    bool m_authenticated = false;
    QTimer m_simTimer;
    double m_startEnergy = 0.0;
    QVariantMap m_pricingConfig;
};

class OCPPManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool connected READ connected NOTIFY connectionChanged)
    Q_PROPERTY(QString csmsUrl READ csmsUrl CONSTANT)
    Q_PROPERTY(QString chargeBoxId READ chargeBoxId CONSTANT)
    Q_PROPERTY(QString protocol READ protocol CONSTANT)
    Q_PROPERTY(int heartbeatInterval READ heartbeatInterval CONSTANT)
    Q_PROPERTY(int reconnectAttempts READ reconnectAttempts NOTIFY connectionChanged)

public:
    explicit OCPPManager(QObject *parent = nullptr);
    ~OCPPManager() override;
    bool connected() const { return m_connected; }
    QString csmsUrl() const { return m_csmsUrl; }
    QString chargeBoxId() const { return m_chargeBoxId; }
    QString protocol() const { return m_protocol; }
    int heartbeatInterval() const { return m_heartbeatInterval; }
    int reconnectAttempts() const { return m_reconnectAttempts; }

    Q_INVOKABLE void sendStatusNotification(int connectorId, const QString &status);
    Q_INVOKABLE void sendMeterValues(int connectorId, double energy, double power);
    Q_INVOKABLE void authorize(const QString &idTag);
    Q_INVOKABLE void simulateDisconnect();
    Q_INVOKABLE void reconnect();
    Q_INVOKABLE void sendAuthorizeRequest(const QString &idTag);
    Q_INVOKABLE void sendStartTransaction(int connectorId);
    Q_INVOKABLE void sendStopTransaction(int transactionId, int meterStop);
    void beginChargingSession(int connectorId, const QString &sessionId,
                              const QString &idTag, double meterStartWh);
    void endChargingSession(int connectorId, const QString &sessionId,
                            double meterStopWh, const QString &reason);

signals:
    void connectionChanged();
    void authorizationResult(bool accepted, const QString &idTag);
    void meterValuesReceived(int connectorId, const QJsonObject &values);
    void transactionStarted(int connectorId, const QString &transactionId);
    void transactionStopped(int transactionId);
    void remoteStopRequested(int connectorId);

private:
    class LibOcppClient;

    void setConnected(bool connected);
    QString normalizedIdTag(const QString &idTag) const;

    bool m_connected = false;
    int m_reconnectAttempts = 0;
    QString m_csmsUrl = "ws://172.29.18.51:9000/ocpp";
    QString m_chargeBoxId = "GT-EVSE-A001";
    QString m_protocol = "OCPP 1.6J";
    int m_heartbeatInterval = 60;
    QTimer m_heartbeatTimer;
    QTimer m_reconnectTimer;
    std::unique_ptr<LibOcppClient> m_client;
};

class ChargerBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY currentTimeChanged)
    Q_PROPERTY(QString currentDate READ currentDate NOTIFY currentTimeChanged)
    Q_PROPERTY(bool ocppConnected READ ocppConnected NOTIFY ocppConnectedChanged)
    Q_PROPERTY(ChargerPort* portA READ portA CONSTANT)
    Q_PROPERTY(ChargerPort* portB READ portB CONSTANT)
    Q_PROPERTY(OCPPManager* ocpp READ ocpp CONSTANT)
    Q_PROPERTY(QVariantMap stationInfo READ stationInfo CONSTANT)
    Q_PROPERTY(QVariantList sessionHistory READ sessionHistory NOTIFY sessionHistoryChanged)
    Q_PROPERTY(QVariantList todayHistory READ todayHistory NOTIFY sessionHistoryChanged)
    Q_PROPERTY(double totalEnergyToday READ totalEnergyToday NOTIFY sessionHistoryChanged)
    Q_PROPERTY(int sessionsToday READ sessionsToday NOTIFY sessionHistoryChanged)
    Q_PROPERTY(double revenueToday READ revenueToday NOTIFY sessionHistoryChanged)

public:
    explicit ChargerBackend(QObject *parent = nullptr);
    ~ChargerBackend() = default;

    QString currentTime() const;
    QString currentDate() const;
    bool ocppConnected() const;
    ChargerPort* portA() const { return m_portA; }
    ChargerPort* portB() const { return m_portB; }
    OCPPManager* ocpp() const { return m_ocpp; }

    QVariantMap stationInfo() const;
    QVariantList sessionHistory() const;
    QVariantList todayHistory() const;
    double totalEnergyToday() const { return m_totalEnergyToday; }
    int sessionsToday() const { return m_sessionsToday; }
    double revenueToday() const { return m_revenueToday; }

    Q_INVOKABLE void stopCharging(const QString &port);
    Q_INVOKABLE void startChargingOnPort(const QString &port);
    Q_INVOKABLE void authenticatePort(const QString &port, int method, const QString &cred);

signals:
    void currentTimeChanged();
    void ocppConnectedChanged();
    void sessionHistoryChanged();

public slots:
    void onPortSessionEnded(const QString &portName, const QString &sessionId,
                           double energy, double cost, double avgPower,
                           double startSoc, double endSoc,
                           const QString &status, int duration, double maxPwr);

private:
    void createDemoHistory();

    QTimer m_clockTimer;
    bool m_ocppConnected = true;
    ChargerPort *m_portA = nullptr;
    ChargerPort *m_portB = nullptr;
    OCPPManager *m_ocpp = nullptr;
    QList<SessionRecord*> m_sessionHistory;

    double m_totalEnergyToday = 0.0;
    int m_sessionsToday = 0;
    double m_revenueToday = 0.0;
};

#endif // CHARGERBACKEND_H
