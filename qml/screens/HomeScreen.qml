import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Rectangle {
    id: root
    color: Theme.bgDark

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 0

        // ── Hero banner ──
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 160
            color: Theme.bgMedium

            Row {
                anchors.fill: parent
                anchors.leftMargin: 28
                anchors.rightMargin: 28
                spacing: 0

                Column {
                    id: heroText
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2

                    Text {
                        text: "EasyEVSE"
                        color: Theme.primary
                        font.pixelSize: 11
                        font.bold: true
                        font.letterSpacing: 4
                    }

                    Text {
                        text: "Trạm Sạc Xe Điện"
                        color: Theme.textPrimary
                        font.pixelSize: 26
                        font.bold: true
                    }

                    Text {
                        text: "Sạc nhanh • An toàn • Thông minh"
                        color: Theme.textSecondary
                        font.pixelSize: 13
                    }

                    // NXP EVK info
                    Item {
                        width: 1
                        height: 4
                    }

                    Rectangle {
                        width: nxpInfoText.implicitWidth + 24
                        height: 24
                        radius: 6
                        color: Qt.rgba(0, 74 / 255, 153 / 255, 0.2)
                        border.color: Qt.rgba(0, 74 / 255, 153 / 255, 0.4)
                        border.width: 1
                        anchors.margins: 0

                        Text {
                            id: nxpInfoText
                            anchors.centerIn: parent
                            text: "NXP EasyEVSE | EV-CHRG-STN-MPU | DY1212W-4856"
                            color: "#5BADF5"
                            font.pixelSize: 9
                            font.weight: Font.DemiBold
                        }
                    }
                }

                Item {
                    width: Math.max(0, parent.width - heroText.width - stationStats.width - 20)
                    height: 1
                }

                // Station stats
                Row {
                    id: stationStats
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 28

                    Repeater {
                        model: [
                            { label: "Cổng online", value: "2/2", color: Theme.primary },
                            { label: "Công suất", value: "240 kW", color: Theme.accent },
                            { label: "Hôm nay", value: "12 phiên", color: Theme.statusDone },
                            { label: "Đã sạc", value: "285 kWh", color: Theme.statusCharging }
                        ]

                        Column {
                            spacing: 4
                            Text {
                                text: modelData.label
                                color: Theme.textMuted
                                font.pixelSize: 10
                            }
                            Text {
                                text: modelData.value
                                color: modelData.color
                                font.pixelSize: 18
                                font.bold: true
                            }
                        }
                    }
                }
            }

            // Bottom border (green line)
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 3
                color: Theme.primary
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

                // Left: Port cards
                Column {
                    width: 420
                    anchors.top: parent.top
                    spacing: 14

                    PortCard {
                        width: 420
                        height: 267
                        portName: backend.portA.name
                        connectorType: backend.portA.connector
                        maxPower: backend.portA.maxPower
                        state: backend.portA.state
                        batteryPercent: backend.portA.batteryPercent
                        energyDelivered: backend.portA.energyDelivered
                        currentPower: backend.portA.currentPower
                        elapsedSeconds: backend.portA.elapsedSeconds

                        onSelected: screenSelect(state === 0 ? "auth" : (state === 1 ? "charging" : "payment"), "A")
                        onDetailsClicked: screenSelect("session_details", "A")
                    }

                    PortCard {
                        width: 420
                        height: 267
                        portName: backend.portB.name
                        connectorType: backend.portB.connector
                        maxPower: backend.portB.maxPower
                        state: backend.portB.state
                        batteryPercent: backend.portB.batteryPercent
                        energyDelivered: backend.portB.energyDelivered
                        currentPower: backend.portB.currentPower
                        elapsedSeconds: backend.portB.elapsedSeconds

                        onSelected: screenSelect(state === 0 ? "auth" : (state === 1 ? "charging" : "payment"), "B")
                        onDetailsClicked: screenSelect("session_details", "B")
                    }
                }

                // Right: Info panel
                Column {
                    anchors.top: parent.top
                    spacing: 14
                    width: parent.width - 440

                    Grid {
                        width: parent.width
                        columns: 2
                        columnSpacing: 10
                        rowSpacing: 10

                        Repeater {
                            model: [
                                { icon: "📖", label: "Hướng dẫn\nsử dụng", screen: "settings" },
                                { icon: "💳", label: "Nạp tiền\ntài khoản", screen: "payment" },
                                { icon: "📋", label: "Lịch sử\nsạc", screen: "history" },
                                { icon: "⚙️", label: "Cài đặt\nhệ thống", screen: "settings" }
                            ]

                            Rectangle {
                                width: (parent.width - 10) / 2
                                height: 80
                                radius: 10
                                color: Theme.bgCard
                                border.color: Theme.textMuted
                                border.width: 1

                                Column {
                                    anchors.centerIn: parent
                                    spacing: 4

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: modelData.icon
                                        font.pixelSize: 22
                                    }
                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: modelData.label
                                        color: Theme.textSecondary
                                        font.pixelSize: 11
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: screenSelect(modelData.screen)
                                }
                            }
                        }
                    }

                    // Pricing card
                    Rectangle {
                        width: parent.width
                        height: 118
                        radius: 10
                        color: Theme.bgCard
                        border.color: Theme.primary
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 8

                            Text {
                                text: "Bảng giá dịch vụ"
                                color: Theme.textPrimary
                                font.pixelSize: 13
                                font.bold: true
                            }

                            Row {
                                spacing: 34
                                Layout.alignment: Qt.AlignHCenter

                                Repeater {
                                    model: [
                                        { rate: "3.500", unit: "đ/kWh", label: "AC Slow", color: Theme.statusDone },
                                        { rate: "9.500", unit: "đ/kWh", label: "DC Fast", color: Theme.statusCharging },
                                        { rate: "12.000", unit: "đ/kWh", label: "DC Ultra", color: Theme.primary },
                                        { rate: "30.000", unit: "đ/lần", label: "Phí khởi tạo", color: Theme.textSecondary }
                                    ]

                                    Column {
                                        spacing: 4
                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: modelData.rate + " " + modelData.unit
                                            color: modelData.color
                                            font.pixelSize: 13
                                            font.bold: true
                                        }
                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: modelData.label
                                            color: Theme.textMuted
                                            font.pixelSize: 9
                                        }
                                    }
                                }
                            }

                            Item { Layout.fillHeight: true }

                            Text {
                                text: "ISO 15118-2 • CCS2 • CHAdeMO • Type 2 • Plug & Charge"
                                color: Theme.textMuted
                                font.pixelSize: 9
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    // System status card
                    Rectangle {
                        width: parent.width
                        height: 118
                        radius: 10
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 8

                            // Connection status row
                            Row {
                                spacing: 24

                                Repeater {
                                    model: [
                                        { label: "Wi-Fi 6", ok: true },
                                        { label: "OCPP 1.6J", ok: backend.ocppConnected },
                                        { label: "NFC PN7160", ok: true },
                                        { label: "Metrology", ok: true }
                                    ]

                                    Row { spacing: 4
                                        Rectangle {
                                            width: 6; height: 6
                                            radius: 3
                                            color: modelData.ok ? Theme.statusReady : Theme.statusError
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                        Text {
                                            text: modelData.label
                                            color: Theme.textMuted
                                            font.pixelSize: 9
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                        Text {
                                            text: modelData.ok ? (modelData.label === "OCPP 1.6J" ? "Online" : "Kết nối") : "Offline"
                                            color: Theme.textSecondary
                                            font.pixelSize: 10
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }
                                }
                            }

                            // Protocol tags
                            Row {
                                spacing: 6

                                Repeater {
                                    model: [
                                        { label: "ISO 15118-2", active: true },
                                        { label: "ISO 15118-20", active: true },
                                        { label: "SAE J1772", active: false },
                                        { label: "SAE J3068", active: false },
                                        { label: "CHAdeMO", active: false },
                                        { label: "OCPP 1.6J", active: false }
                                    ]

                                    Rectangle {
                                        width: protocolLabel.implicitWidth + 16
                                        radius: 5
                                        height: 18
                                        color: modelData.active ? Qt.rgba(0, 1, 136 / 255, 0.15) : Theme.bgLight
                                        Text {
                                            id: protocolLabel
                                            anchors.centerIn: parent
                                            text: modelData.label
                                            color: modelData.active ? Theme.primary : Theme.textMuted
                                            font.pixelSize: 8
                                            font.weight: Font.DemiBold
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    signal screenSelect(string screen, string port)
}
