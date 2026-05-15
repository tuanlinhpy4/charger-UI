pragma Singleton
import QtQuick 2.15

QtObject {
    // ── Brand ──
    readonly property string brandName: "EasyEVSE"
    readonly property string brandTagline: "EV CHARGING STATION"

    // ── Colors ──
    readonly property color primary: "#00FF88"
    readonly property color primaryDark: "#00CC6A"
    readonly property color primaryLight: "#69F0AE"
    readonly property color accent: "#00BCD4"
    readonly property color accentDark: "#00838F"

    readonly property color bgDark: "#0D1117"
    readonly property color bgMedium: "#161B22"
    readonly property color bgLight: "#21262D"
    readonly property color bgCard: "#1C2128"
    readonly property color bgCardHover: "#2D333B"

    readonly property color textPrimary: "#F0F6FC"
    readonly property color textSecondary: "#8B949E"
    readonly property color textMuted: "#484F58"
    readonly property color textAccent: "#58A6FF"

    readonly property color statusReady: "#238636"
    readonly property color statusCharging: "#1F6FEB"
    readonly property color statusDone: "#9E6A03"
    readonly property color statusError: "#DA3633"
    readonly property color statusOffline: "#484F58"

    // ── Port colors ──
    readonly property color portA: "#0077B6"
    readonly property color portALight: "#00B4D8"
    readonly property color portB: "#2D6A4F"
    readonly property color portBLight: "#52B788"

    // ── Glows ──
    readonly property color glowGreen: "#00FF88"
    readonly property color glowBlue: "#00D4FF"
    readonly property color glowOrange: "#FF9500"
    readonly property color glowRed: "#FF3B30"

    // ── Font sizes ──
    readonly property real fontHuge: 64
    readonly property real fontTitle: 32
    readonly property real fontHeading: 24
    readonly property real fontSubheading: 18
    readonly property real fontBody: 14
    readonly property real fontCaption: 12
    readonly property real fontMicro: 10

    // ── Spacing ──
    readonly property real spacingXS: 4
    readonly property real spacingS: 8
    readonly property real spacingM: 16
    readonly property real spacingL: 24
    readonly property real spacingXL: 32
    readonly property real spacingXXL: 48

    // ── Radius ──
    readonly property real radiusS: 6
    readonly property real radiusM: 12
    readonly property real radiusL: 16
    readonly property real radiusXL: 24
    readonly property real radiusRound: 9999

    // ── Screen dimensions ──
    readonly property real screenW: 1024
    readonly property real screenH: 600

    // ── Navigation ──
    readonly property real navHeight: 60
    readonly property real topBarHeight: 52

    // ── Animations ──
    readonly property bool animationsEnabled: false
    readonly property bool chartsEnabled: false
    readonly property int animFast: 150
    readonly property int animNormal: 300
    readonly property int animSlow: 500

    function formatEnergy(kwh) {
        if (kwh >= 1000) return (kwh / 1000).toFixed(2) + " MWh"
        return kwh.toFixed(2) + " kWh"
    }

    function formatPower(kw) {
        return kw.toFixed(1) + " kW"
    }

    function formatTime(sec) {
        var h = Math.floor(sec / 3600)
        var m = Math.floor((sec % 3600) / 60)
        var s = sec % 60
        return twoDigits(h) + ":" + twoDigits(m) + ":" + twoDigits(s)
    }

    function twoDigits(value) {
        return value < 10 ? "0" + value : String(value)
    }

    function formatCurrency(amount) {
        return amount.toLocaleString('vi-VN') + " đ"
    }
}
