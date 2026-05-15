import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import "components"
import "screens"

ApplicationWindow {
    id: root
    visible: true
    width: 1280
    height: 800
    minimumWidth: 1280
    minimumHeight: 800
    maximumWidth: 1280
    maximumHeight: 800
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

    StackView {
        id: stackView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        initialItem: homeScreen
    }

    TopBar {
        id: topBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: Theme.topBarHeight
        currentScreen: root.currentScreen

        onNavClicked: function(screen) {
            root.currentScreen = screen
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

    function navigateTo(screen, port) {
        if (port !== undefined)
            root.selectedPort = port

        root.currentScreen = screen
        switch(screen) {
            case "home":
                stackView.replace(homeScreen, {}, StackView.Immediate)
                break
            case "ports":
                stackView.replace(portSelectionScreen, {}, StackView.Immediate)
                break
            case "auth":
                stackView.replace(authScreen, {}, StackView.Immediate)
                break
            case "charging":
                stackView.replace(chargingScreen, {}, StackView.Immediate)
                break
            case "session_details":
                stackView.replace(sessionDetailsScreen, {}, StackView.Immediate)
                break
            case "payment":
                stackView.replace(paymentScreen, {}, StackView.Immediate)
                break
            case "history":
                stackView.replace(historyScreen, {}, StackView.Immediate)
                break
            case "settings":
                stackView.replace(settingsScreen, {}, StackView.Immediate)
                break
            default:
                stackView.replace(homeScreen, {}, StackView.Immediate)
        }
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
