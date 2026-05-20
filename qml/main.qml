import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import "components"
import "screens"

ApplicationWindow {
    id: root
    visible: true
    width: Screen.width > 0 ? Screen.width : 800
    height: Screen.height > 0 ? Screen.height : 480
    visibility: Window.FullScreen
    flags: Qt.FramelessWindowHint
    title: "EasyEVSE — EV Charging Station"
    color: "#0D1117"

    // ── Global screen navigation state ──
    property string currentScreen: "home"
    property string selectedPort: "A"
    property bool isFullScreen: true

    Component.onCompleted: {
        var startupPort = startupValueFromArgs("--port=")
        if (startupPort !== "")
            root.selectedPort = startupPort

        var startupScreen = startupValueFromArgs("--screen=")
        if (startupScreen !== "" && startupScreen !== "home")
            root.navigateTo(startupScreen, root.selectedPort)
    }

    Item {
        id: screenHost
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom

        Loader {
            id: homeLoader
            anchors.fill: parent
            active: true
            visible: root.currentScreen === "home"
            sourceComponent: homeScreen
        }

        Loader {
            id: portSelectionLoader
            anchors.fill: parent
            active: false
            visible: root.currentScreen === "ports"
            sourceComponent: portSelectionScreen
        }

        Loader {
            id: authLoader
            anchors.fill: parent
            active: false
            visible: root.currentScreen === "auth"
            sourceComponent: authScreen
        }

        Loader {
            id: chargingLoader
            anchors.fill: parent
            active: false
            visible: root.currentScreen === "charging"
            sourceComponent: chargingScreen
        }

        Loader {
            id: sessionDetailsLoader
            anchors.fill: parent
            active: false
            visible: root.currentScreen === "session_details"
            sourceComponent: sessionDetailsScreen
        }

        Loader {
            id: paymentLoader
            anchors.fill: parent
            active: false
            visible: root.currentScreen === "payment"
            sourceComponent: paymentScreen
        }

        Loader {
            id: historyLoader
            anchors.fill: parent
            active: false
            visible: root.currentScreen === "history"
            sourceComponent: historyScreen
        }

        Loader {
            id: settingsLoader
            anchors.fill: parent
            active: false
            visible: root.currentScreen === "settings"
            sourceComponent: settingsScreen
        }
    }

    TopBar {
        id: topBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: root.width <= 900 || root.height <= 520 ? 44 : Theme.topBarHeight
        currentScreen: root.currentScreen

        onNavClicked: function(screen) {
            root.navigateTo(screen)
        }
    }

    // ── Navigation ──
    function startupValueFromArgs(prefix) {
        for (var i = 0; i < Qt.application.arguments.length; ++i) {
            var arg = Qt.application.arguments[i]
            if (arg.indexOf(prefix) === 0)
                return arg.substring(prefix.length)
        }
        return ""
    }

    function normalizeScreen(screen) {
        switch(screen) {
            case "home":
            case "ports":
            case "auth":
            case "charging":
            case "session_details":
            case "payment":
            case "history":
            case "settings":
                return screen
            default:
                return "home"
        }
    }

    function loaderForScreen(screen) {
        switch(screen) {
            case "home": return homeLoader
            case "ports": return portSelectionLoader
            case "auth": return authLoader
            case "charging": return chargingLoader
            case "session_details": return sessionDetailsLoader
            case "payment": return paymentLoader
            case "history": return historyLoader
            case "settings": return settingsLoader
            default: return homeLoader
        }
    }

    function navigateTo(screen, port) {
        if (port !== undefined)
            root.selectedPort = port

        screen = normalizeScreen(screen)
        if (root.currentScreen === screen)
            return

        var loader = loaderForScreen(screen)
        if (loader !== null)
            loader.active = true

        root.currentScreen = screen
    }

    // ── Screen instances ──
    Component {
        id: homeScreen
        HomeScreen {
            onScreenSelect: function(screen, port) {
                root.navigateTo(screen, port)
            }
        }
    }

    Component {
        id: portSelectionScreen
        PortSelectionScreen {
            selectedPort: root.selectedPort
            onScreenSelect: function(screen, port) { root.navigateTo(screen, port) }
        }
    }

    Component {
        id: authScreen
        AuthScreen {
            selectedPort: root.selectedPort
            onScreenSelect: function(screen, port) { root.navigateTo(screen, port) }
        }
    }

    Component {
        id: chargingScreen
        ChargingScreen {
            selectedPort: root.selectedPort
            screenActive: root.currentScreen === "charging"
            onScreenSelect: function(screen, port) { root.navigateTo(screen, port) }
        }
    }

    Component {
        id: sessionDetailsScreen
        SessionDetailsScreen {
            selectedPort: root.selectedPort
            onScreenSelect: function(screen, port) { root.navigateTo(screen, port) }
        }
    }

    Component {
        id: paymentScreen
        PaymentScreen {
            selectedPort: root.selectedPort
            onScreenSelect: function(screen, port) { root.navigateTo(screen, port) }
        }
    }

    Component {
        id: historyScreen
        HistoryScreen {
            onScreenSelect: function(screen, port) { root.navigateTo(screen, port) }
        }
    }

    Component {
        id: settingsScreen
        SettingsScreen {
            onScreenSelect: function(screen, port) { root.navigateTo(screen, port) }
        }
    }

    // ── Keyboard shortcuts ──
    Item {
        anchors.fill: parent
        focus: true

        Component.onCompleted: forceActiveFocus()

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Escape) {
                if (root.currentScreen !== "home")
                    root.navigateTo("home", root.selectedPort)
            }
            if (event.key === Qt.Key_F11) {
                root.isFullScreen = !root.isFullScreen
                root.visibility = root.isFullScreen ? Window.FullScreen : Window.Windowed
            }
        }
    }
}
