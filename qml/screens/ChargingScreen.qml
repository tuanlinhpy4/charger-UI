import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Rectangle {
    id: root
    color: Theme.bgDark

    property string selectedPort: "A"
    property var currentPort: selectedPort === "A" ? backend.portA : backend.portB

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 0

        // ── Section header ──
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 52
            color: Theme.bgMedium

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 12

                // Back button
                Rectangle {
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    Layout.alignment: Qt.AlignVCenter
                    radius: 16
                    color: Theme.bgLight

                    Text {
                        anchors.centerIn: parent
                        text: "←"
                        color: Theme.textPrimary
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: screenSelect("home", selectedPort)
                    }
                }

                Column {
                    spacing: 2
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 330

                    Text {
                        text: "Đang sạc — " + currentPort.name
                        color: Theme.textPrimary
                        font.pixelSize: 15
                        font.bold: true
                    }

                    Text {
                        text: currentPort.connector + " • " + currentPort.maxPower + " kW • ISO 15118-2"
                        color: Theme.textMuted
                        font.pixelSize: 10
                    }
                }

                Item { Layout.fillWidth: true }

                // Status pill
                Rectangle {
                    Layout.preferredWidth: chargingStatusRow.implicitWidth + 24
                    Layout.preferredHeight: 24
                    Layout.alignment: Qt.AlignVCenter
                    radius: 12
                    color: "#0D1F3C"

                    Row {
                        id: chargingStatusRow
                        anchors.centerIn: parent
                        spacing: 5

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 7; height: 7
                            radius: 4
                            color: Theme.statusCharging

                            SequentialAnimation on opacity {
                                loops: Animation.Infinite
                                running: Theme.animationsEnabled
                                NumberAnimation { to: 0.2; duration: 800 }
                                NumberAnimation { to: 1.0; duration: 800 }
                            }
                        }

                        Text {
                            text: "ĐANG SẠC"
                            color: Theme.statusCharging
                            font.pixelSize: 10
                            font.bold: true
                        }
                    }
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: Qt.rgba(1, 1, 1, 0.04)
            }
        }

        // ── Main content ──
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Row {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                // ── Left panel ──
                Rectangle {
                    width: 420
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    radius: 14
                    color: Theme.bgCard
                    border.color: Theme.textMuted
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 14

                        // Power display
                        Column {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 2

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: currentPort.currentPower.toFixed(1)
                                color: Theme.statusCharging
                                font.pixelSize: 64
                                font.bold: true
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "kW"
                                color: Theme.textSecondary
                                font.pixelSize: 18
                            }
                        }

                        // Charging stats (3-column)
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 60
                            radius: 10
                            color: Theme.bgLight

                            RowLayout {
                                anchors.fill: parent

                                // Energy
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    color: "transparent"
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 4
                                        Text {
                                            text: "Năng lượng"
                                            color: Theme.textMuted
                                            font.pixelSize: 9
                                        }
                                        Text {
                                            text: currentPort.energyDelivered.toFixed(2) + " kWh"
                                            color: Theme.accent
                                            font.pixelSize: 13
                                            font.bold: true
                                        }
                                    }
                                }

                                // Time
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    color: "transparent"
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 4
                                        Text {
                                            text: "Thời gian"
                                            color: Theme.textMuted
                                            font.pixelSize: 9
                                        }
                                        Text {
                                            text: Theme.formatTime(currentPort.elapsedSeconds)
                                            color: Theme.textPrimary
                                            font.pixelSize: 13
                                            font.bold: true
                                        }
                                    }
                                }

                                // Cost
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    color: "transparent"
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 4
                                        Text {
                                            text: "Giá tiền"
                                            color: Theme.textMuted
                                            font.pixelSize: 9
                                        }
                                        Text {
                                            text: (currentPort.energyDelivered * 3500).toLocaleString('vi-VN') + " đ"
                                            color: Theme.statusDone
                                            font.pixelSize: 13
                                            font.bold: true
                                        }
                                    }
                                }
                            }
                        }

                        // Battery bar
                        Column {
                            spacing: 5
                            Layout.fillWidth: true

                            RowLayout {
                                width: parent.width
                                height: Math.max(pinLabel.implicitHeight, pinValue.implicitHeight)
                                Text {
                                    id: pinLabel
                                    text: "Pin xe"
                                    color: Theme.textSecondary
                                    font.pixelSize: 11
                                }
                                Item { Layout.fillWidth: true }
                                Text {
                                    id: pinValue
                                    text: Math.floor(currentPort.batteryPercent) + "%"
                                    color: currentPort.batteryPercent > 80 ? Theme.statusReady :
                                           currentPort.batteryPercent > 50 ? Theme.statusCharging :
                                           currentPort.batteryPercent > 20 ? Theme.statusDone : Theme.statusError
                                    font.pixelSize: 13
                                    font.bold: true
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                height: 18
                                radius: 10
                                color: Theme.bgLight

                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    height: parent.height - 4
                                    width: (parent.width - 4) * currentPort.batteryPercent / 100.0
                                    radius: 8
                                    color: currentPort.batteryPercent > 80 ? Theme.statusReady :
                                           currentPort.batteryPercent > 50 ? Theme.statusCharging :
                                           currentPort.batteryPercent > 20 ? Theme.statusDone : Theme.statusError

                                    Behavior on width {
                                        enabled: Theme.animationsEnabled
                                        NumberAnimation { duration: Theme.animationsEnabled ? 400 : 0; easing.type: Easing.OutCubic }
                                    }
                                }
                            }
                        }

                        // Chart box
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 120
                            radius: 10
                            color: Theme.bgLight

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 4

                                Text {
                                    text: "Đường cong sạc"
                                    color: Theme.textMuted
                                    font.pixelSize: 9
                                }

                                Item {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true

                                    Canvas {
                                        id: powerChart
                                        anchors.fill: parent
                                        antialiasing: false

                                        onPaint: {
                                            var ctx = getContext("2d")
                                            var w = width
                                            var h = height
                                            ctx.clearRect(0, 0, w, h)

                                            ctx.strokeStyle = "#30363D"
                                            ctx.lineWidth = 1
                                            for (var i = 1; i < 4; i++) {
                                                var y = h * i / 4
                                                ctx.beginPath()
                                                ctx.moveTo(0, y)
                                                ctx.lineTo(w, y)
                                                ctx.stroke()
                                            }

                                            ctx.strokeStyle = Theme.statusCharging
                                            ctx.lineWidth = 2
                                            ctx.beginPath()
                                            for (var x = 0; x < w; x++) {
                                                var pct = x / w * 100
                                                var pwr = currentPort.maxPower
                                                if (pct > 80) pwr = currentPort.maxPower * Math.max(0.2, 1.0 - (pct - 80) / 20.0)
                                                if (pct > 95) pwr = currentPort.maxPower * 0.2
                                                var y = h - (pwr / currentPort.maxPower) * h
                                                if (x === 0) ctx.moveTo(x, y)
                                                else ctx.lineTo(x, y)
                                            }
                                            ctx.stroke()

                                            var cx = currentPort.batteryPercent / 100 * w
                                            var cpwr = currentPort.currentPower
                                            var cy = h - (cpwr / currentPort.maxPower) * h
                                            ctx.fillStyle = Theme.accent
                                            ctx.beginPath()
                                            ctx.arc(cx, cy, 4, 0, Math.PI * 2)
                                            ctx.fill()
                                        }

                                        Timer {
                                            interval: 2000
                                            running: Theme.chartsEnabled
                                            repeat: true
                                            onTriggered: powerChart.requestPaint()
                                        }

                                        Component.onCompleted: requestPaint()
                                        Connections {
                                            target: currentPort
                                            function onBatteryPercentChanged() { powerChart.requestPaint() }
                                            function onCurrentPowerChanged() { powerChart.requestPaint() }
                                        }
                                    }
                                }

                                Text {
                                    text: "0%              25%              50%              75%             100%"
                                    color: Theme.textMuted
                                    font.pixelSize: 8
                                }
                            }
                        }

                        // Chips
                        Row {
                            spacing: 7
                            Layout.alignment: Qt.AlignHCenter

                            Repeater {
                                model: [
                                    { label: "SOC", value: Math.floor(currentPort.batteryPercent) + "%" },
                                    { label: "Voltage", value: "400V" },
                                    { label: "Current", value: (currentPort.currentPower / 400 * 1000).toFixed(0) + "A" },
                                    { label: "Energy", value: currentPort.energyDelivered.toFixed(2) + " kWh" }
                                ]

                                Rectangle {
                                    radius: 7
                                    color: Theme.bgLight
                                    height: 42
                                    width: 74

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2

                                        Text {
                                            id: chipLabel
                                            text: modelData.label
                                            color: Theme.textMuted
                                            font.pixelSize: 8
                                        }

                                        Text {
                                            text: modelData.value
                                            color: Theme.textPrimary
                                            font.pixelSize: 12
                                            font.bold: true
                                        }
                                    }
                                }
                            }
                        }

                        Item { Layout.fillHeight: true }

                        // Bottom buttons
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10

                            Rectangle {
                                Layout.preferredWidth: 140
                                Layout.preferredHeight: 38
                                radius: 20
                                color: Theme.bgLight
                                border.color: Theme.textMuted
                                border.width: 1

                                Text {
                                    anchors.centerIn: parent
                                    text: "Chi tiết phiên ⓘ"
                                    color: Theme.textSecondary
                                    font.pixelSize: 11
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: screenSelect("session_details", selectedPort)
                                }
                            }

                            Item { Layout.fillWidth: true }

                            Rectangle {
                                Layout.preferredWidth: 160
                                Layout.preferredHeight: 38
                                radius: 20
                                color: Theme.statusError

                                Rectangle {
                                    anchors.fill: parent
                                    anchors.margins: -2
                                    radius: parent.radius + 2
                                    color: Theme.statusError
                                    opacity: 0.25
                                    z: -1
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: "⏹ Dừng sạc"
                                    color: "#ffffff"
                                    font.pixelSize: 12
                                    font.bold: true
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: stopCharging()
                                }
                            }
                        }
                    }
                }

                // ── Right panel ──
                Column {
                    spacing: 12
                    anchors.verticalCenter: parent.verticalCenter
                    width: 460

                    // Session ID info card
                    Rectangle {
                        width: 460
                        height: 64
                        radius: 10
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 0

                            Column {
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2
                                Text {
                                    text: "Mã phiên sạc"
                                    color: Theme.textMuted
                                    font.pixelSize: 10
                                }
                                Text {
                                    text: "#EV" + String(Math.floor(Math.random() * 900000 + 100000))
                                    color: Theme.textPrimary
                                    font.pixelSize: 14
                                    font.bold: true
                                }
                            }

                            Item { Layout.fillWidth: true }

                            Column {
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2
                                Text {
                                    text: "Bắt đầu"
                                    color: Theme.textMuted
                                    font.pixelSize: 10
                                }
                                Text {
                                    text: backend.currentTime
                                    color: Theme.textPrimary
                                    font.pixelSize: 14
                                    font.bold: true
                                }
                            }
                        }
                    }

                    // Arc gauge
                    Rectangle {
                        width: 460
                        height: 170
                        radius: 10
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 6

                            Text {
                                text: "Công suất thực"
                                color: Theme.textSecondary
                                font.pixelSize: 11
                            }

                            Item { Layout.fillHeight: true }

                            Item {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 110

                                Canvas {
                                    id: gaugeCanvas
                                    anchors.fill: parent
                                    antialiasing: false

                                    onPaint: {
                                        var ctx = getContext("2d")
                                        var cx = width / 2
                                        var cy = height
                                        var r = Math.min(cx, cy) - 10

                                        ctx.clearRect(0, 0, width, height)

                                        ctx.strokeStyle = Theme.bgLight
                                        ctx.lineWidth = 10
                                        ctx.lineCap = "round"
                                        ctx.beginPath()
                                        ctx.arc(cx, cy, r, Math.PI, 0, false)
                                        ctx.stroke()

                                        var pct = currentPort.currentPower / currentPort.maxPower
                                        var angle = Math.PI - pct * Math.PI
                                        var gradient = ctx.createLinearGradient(cx - r, cy, cx + r, cy)
                                        gradient.addColorStop(0, Theme.statusCharging)
                                        gradient.addColorStop(1, Theme.primary)
                                        ctx.strokeStyle = gradient
                                        ctx.lineWidth = 10
                                        ctx.beginPath()
                                        ctx.arc(cx, cy, r, Math.PI, angle, false)
                                        ctx.stroke()

                                        ctx.fillStyle = Theme.textPrimary
                                        ctx.font = "bold 26px sans-serif"
                                        ctx.textAlign = "center"
                                        ctx.fillText(currentPort.currentPower.toFixed(1), cx, cy - 20)
                                        ctx.font = "10px sans-serif"
                                        ctx.fillStyle = Theme.textMuted
                                        ctx.textAlign = "center"
                                        ctx.fillText("kW", cx, cy + 2)
                                    }

                                    Timer {
                                        interval: 1000
                                        running: Theme.chartsEnabled
                                        repeat: true
                                        onTriggered: gaugeCanvas.requestPaint()
                                    }

                                    Component.onCompleted: requestPaint()
                                    Connections {
                                        target: currentPort
                                        function onCurrentPowerChanged() { gaugeCanvas.requestPaint() }
                                    }
                                }
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: "0 kW"; color: Theme.textMuted; font.pixelSize: 9 }
                                Item { Layout.fillWidth: true }
                                Text { text: currentPort.maxPower + " kW max"; color: Theme.textMuted; font.pixelSize: 9 }
                            }
                        }
                    }

                    // Session info card
                    Rectangle {
                        width: 460
                        height: 150
                        radius: 10
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 10

                            Text {
                                text: "Thông tin phiên sạc"
                                color: Theme.textSecondary
                                font.pixelSize: 11
                            }

                            Grid {
                                columns: 2
                                columnSpacing: 8
                                rowSpacing: 6
                                Layout.fillWidth: true

                                Repeater {
                                    model: [
                                        { label: "Giao thức", value: "ISO 15118-2" },
                                        { label: "Đầu nối", value: currentPort.connector },
                                        { label: "Mã ID", value: "••••••••" },
                                        { label: "OCPP", value: backend.ocppConnected ? "1.6J — Online" : "Offline" }
                                    ]

                                    Rectangle {
                                        width: (parent.width - parent.columnSpacing) / 2
                                        radius: 8
                                        color: Theme.bgLight
                                        height: 36

                                        Column {
                                            anchors.centerIn: parent
                                            spacing: 2
                                            Text {
                                                text: modelData.label
                                                color: Theme.textMuted
                                                font.pixelSize: 9
                                            }
                                            Text {
                                                text: modelData.value
                                                color: Theme.textPrimary
                                                font.pixelSize: 11
                                                font.bold: true
                                            }
                                        }
                                    }
                                }
                            }

                            Item { Layout.fillHeight: true }

                            Text {
                                text: "Metrology: Đã hiệu chuẩn ✓ | An toàn: GFCI OK ✓ | Relay: ON ✓"
                                color: Theme.textMuted
                                font.pixelSize: 9
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    // Notification box
                    Rectangle {
                        width: 460
                        height: 56
                        radius: 10
                        color: Theme.bgCard
                        border.color: Theme.primary
                        border.width: 1

                        Row {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 10

                            Rectangle {
                                width: 28; height: 28
                                radius: 14
                                color: "#0d2818"
                                anchors.verticalCenter: parent.verticalCenter

                                Text {
                                    anchors.centerIn: parent
                                    text: "ℹ"
                                    color: Theme.primary
                                    font.pixelSize: 12
                                }
                            }

                            Column {
                                spacing: 2
                                anchors.verticalCenter: parent.verticalCenter

                                Text {
                                    text: "Sạc ổn định • Bảo vệ quá dòng và GFCI hoạt động"
                                    color: Theme.textPrimary
                                    font.pixelSize: 10
                                }

                                Text {
                                    text: "Cập nhật: " + backend.currentTime
                                    color: Theme.textMuted
                                    font.pixelSize: 9
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function stopCharging() {
        stopConfirm.visible = true
    }

    function doStopCharging() {
        if (selectedPort === "A") {
            backend.portA.stopCharging()
        } else {
            backend.portB.stopCharging()
        }
        stopConfirm.visible = false
        screenSelect("home", selectedPort)
    }

    // Stop confirmation dialog
    Rectangle {
        id: stopConfirm
        visible: false
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.5)

        Rectangle {
            anchors.centerIn: parent
            width: 380
            height: 260
            radius: 16
            color: Theme.bgCard

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 32
                spacing: 16

                Item { Layout.fillHeight: true }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "⚠"
                    font.pixelSize: 48
                    color: Theme.statusError
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Dừng sạc?"
                    color: Theme.textPrimary
                    font.pixelSize: 22
                    font.bold: true
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Bạn có chắc muốn dừng phiên sạc hiện tại không?"
                    color: Theme.textSecondary
                    font.pixelSize: 13
                    horizontalAlignment: Text.AlignHCenter
                }

                Item { Layout.fillHeight: true }

                Row {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 12

                    Rectangle {
                        width: 140; height: 44
                        radius: 22
                        color: Theme.bgLight

                        Text {
                            anchors.centerIn: parent
                            text: "Hủy"
                            color: Theme.textSecondary
                            font.pixelSize: 13
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: stopConfirm.visible = false
                        }
                    }

                    Rectangle {
                        width: 180; height: 44
                        radius: 22
                        color: Theme.statusError

                        Text {
                            anchors.centerIn: parent
                            text: "⏹ Dừng sạc"
                            color: "#ffffff"
                            font.pixelSize: 13
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: doStopCharging()
                        }
                    }
                }
            }
        }
    }

    signal screenSelect(string screen, string port)
}
