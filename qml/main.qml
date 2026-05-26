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
    property bool navigationBenchmarkEnabled: hasArg("--benchmark-navigation")
    property var navigationBenchmarkScreens: [
        "ports",
        "auth",
        "charging",
        "session_details",
        "payment",
        "history",
        "settings",
        "home"
    ]
    property var navigationBenchmarkResults: []
    property int navigationBenchmarkIndex: 0
    property int navigationBenchmarkCycles: 5
    property double navigationBenchmarkStartedAt: 0
    property string navigationBenchmarkFrom: ""
    property string navigationBenchmarkTo: ""
    property bool navigationBenchmarkWaitingFrame: false

    Component.onCompleted: {
        var startupPort = startupValueFromArgs("--port=")
        if (startupPort !== "")
            root.selectedPort = startupPort

        var startupScreen = startupValueFromArgs("--screen=")
        if (startupScreen !== "" && startupScreen !== "home")
            root.navigateTo(startupScreen, root.selectedPort)

        if (root.navigationBenchmarkEnabled)
            navigationBenchmarkStartTimer.start()
    }

    Item {
        id: screenHost
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom

        Loader {
            id: homeLoader
            property bool current: root.currentScreen === "home"
            anchors.fill: parent
            active: true
            visible: current
            sourceComponent: homeScreen
        }

        Loader {
            id: portSelectionLoader
            property bool current: root.currentScreen === "ports"
            anchors.fill: parent
            active: true
            visible: current
            sourceComponent: portSelectionScreen
        }

        Loader {
            id: authLoader
            property bool current: root.currentScreen === "auth"
            anchors.fill: parent
            active: true
            visible: current
            sourceComponent: authScreen
        }

        Loader {
            id: chargingLoader
            property bool current: root.currentScreen === "charging"
            anchors.fill: parent
            active: true
            visible: current
            sourceComponent: chargingScreen
        }

        Loader {
            id: sessionDetailsLoader
            property bool current: root.currentScreen === "session_details"
            anchors.fill: parent
            active: true
            visible: current
            sourceComponent: sessionDetailsScreen
        }

        Loader {
            id: paymentLoader
            property bool current: root.currentScreen === "payment"
            anchors.fill: parent
            active: true
            visible: current
            sourceComponent: paymentScreen
        }

        Loader {
            id: historyLoader
            property bool current: root.currentScreen === "history"
            anchors.fill: parent
            active: true
            visible: current
            sourceComponent: historyScreen
        }

        Loader {
            id: settingsLoader
            property bool current: root.currentScreen === "settings"
            anchors.fill: parent
            active: true
            visible: current
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

    function hasArg(name) {
        for (var i = 0; i < Qt.application.arguments.length; ++i) {
            if (Qt.application.arguments[i] === name)
                return true
        }
        return false
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

    function navigationBenchmarkPreloadSummary() {
        var parts = []
        for (var i = 0; i < navigationBenchmarkScreens.length; ++i) {
            var screen = navigationBenchmarkScreens[i]
            var loader = loaderForScreen(screen)
            parts.push(screen + ":" + (loader && loader.item !== null ? "ready" : "missing"))
        }
        return parts.join(" ")
    }

    function startNavigationBenchmark() {
        navigationBenchmarkResults = []
        navigationBenchmarkIndex = 0
        console.log("[NAV_BENCH] preload " + navigationBenchmarkPreloadSummary())
        navigationBenchmarkStepTimer.start()
    }

    function runNavigationBenchmarkStep() {
        if (navigationBenchmarkIndex >= navigationBenchmarkScreens.length * navigationBenchmarkCycles) {
            finishNavigationBenchmark()
            return
        }

        var targetScreen = navigationBenchmarkScreens[navigationBenchmarkIndex % navigationBenchmarkScreens.length]
        if (targetScreen === root.currentScreen) {
            ++navigationBenchmarkIndex
            navigationBenchmarkStepTimer.start()
            return
        }

        navigationBenchmarkFrom = root.currentScreen
        navigationBenchmarkTo = targetScreen
        navigationBenchmarkStartedAt = Date.now()
        navigationBenchmarkWaitingFrame = true
        navigationBenchmarkFrameTimeout.restart()
        var navigateCallStartedAt = Date.now()
        root.navigateTo(targetScreen, root.selectedPort)
        console.log("[NAV_BENCH_SYNC] " + navigationBenchmarkFrom + " -> " +
                    navigationBenchmarkTo + " navigateCall=" +
                    (Date.now() - navigateCallStartedAt) + "ms")
    }

    function recordNavigationBenchmarkFrame(source) {
        if (!navigationBenchmarkWaitingFrame)
            return

        navigationBenchmarkWaitingFrame = false
        navigationBenchmarkFrameTimeout.stop()

        var elapsed = Date.now() - navigationBenchmarkStartedAt
        navigationBenchmarkResults.push(elapsed)
        console.log("[NAV_BENCH] " + navigationBenchmarkFrom + " -> " +
                    navigationBenchmarkTo + " " + elapsed + "ms via " + source)

        ++navigationBenchmarkIndex
        navigationBenchmarkStepTimer.start()
    }

    function percentile(sortedValues, p) {
        if (sortedValues.length === 0)
            return 0

        var index = Math.ceil((p / 100.0) * sortedValues.length) - 1
        index = Math.max(0, Math.min(sortedValues.length - 1, index))
        return sortedValues[index]
    }

    function finishNavigationBenchmark() {
        var values = navigationBenchmarkResults.slice(0)
        values.sort(function(a, b) { return a - b })

        var sum = 0
        for (var i = 0; i < values.length; ++i)
            sum += values[i]

        var avg = values.length > 0 ? sum / values.length : 0
        console.log("[NAV_BENCH] summary count=" + values.length +
                    " avg=" + avg.toFixed(1) + "ms" +
                    " min=" + percentile(values, 0).toFixed(1) + "ms" +
                    " p50=" + percentile(values, 50).toFixed(1) + "ms" +
                    " p95=" + percentile(values, 95).toFixed(1) + "ms" +
                    " max=" + percentile(values, 100).toFixed(1) + "ms")
        Qt.quit()
    }

    Timer {
        id: navigationBenchmarkStartTimer
        interval: 1000
        repeat: false
        onTriggered: root.startNavigationBenchmark()
    }

    Timer {
        id: navigationBenchmarkStepTimer
        interval: 250
        repeat: false
        onTriggered: root.runNavigationBenchmarkStep()
    }

    Timer {
        id: navigationBenchmarkFrameTimeout
        interval: 1000
        repeat: false
        onTriggered: root.recordNavigationBenchmarkFrame("timeout")
    }

    Connections {
        target: root
        ignoreUnknownSignals: true
        function onAfterRendering() {
            root.recordNavigationBenchmarkFrame("afterRendering")
        }
        function onFrameSwapped() {
            root.recordNavigationBenchmarkFrame("frameSwapped")
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
