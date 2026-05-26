#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QFontDatabase>
#include "chargerbackend.h"

int main(int argc, char *argv[])
{
    if (qEnvironmentVariableIsEmpty("QT_QUICK_BACKEND"))
        qputenv("QT_QUICK_BACKEND", QByteArrayLiteral("software"));
    if (qEnvironmentVariableIsEmpty("QSG_RENDER_LOOP"))
        qputenv("QSG_RENDER_LOOP", QByteArrayLiteral("basic"));

    QGuiApplication app(argc, argv);

    app.setApplicationName("GETECH EV Charger");
    app.setApplicationVersion("2.4.1");
    app.setOrganizationName("GETECH");

    // Register C++ types for QML
    qmlRegisterType<ChargerPort>("EVCharger", 1, 0, "ChargerPort");
    qmlRegisterType<OCPPManager>("EVCharger", 1, 0, "OCPPManager");

    // Singleton for Theme
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/qml/components/Theme.qml")), "EVCharger", 1, 0, "Theme");

    // Create backend and expose to QML
    ChargerBackend backend;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("backend", &backend);

    // Set default style
    QQuickStyle::setStyle("Fusion");

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
