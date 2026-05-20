import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Rectangle {
    id: root
    color: Theme.bgDark

    property int selectedSection: 0
    property int brightnessValue: 80

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 0

        // Header
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 52
            color: Theme.bgMedium

            Row {
                anchors.fill: parent
                anchors.leftMargin: 20
                spacing: 12

                Rectangle {
                    width: 32; height: 32
                    radius: 16
                    color: Theme.bgLight
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        anchors.centerIn: parent
                        text: "←"
                        color: Theme.textPrimary
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: screenSelect("home", "A")
                    }
                }

                Text {
                    text: "Cài đặt hệ thống"
                    color: Theme.textPrimary
                    font.pixelSize: 17
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: Qt.rgba(1, 1, 1, 0.04)
            }
        }

        // Main layout
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Row {
                anchors.fill: parent
                anchors.margins: 24
                spacing: 0

                // Sidebar
                Column {
                    width: 200
                    spacing: 4

                    Repeater {
                        model: [
                            { icon: "🖥️", label: "Màn hình & Giao diện" },
                            { icon: "🌐", label: "Kết nối mạng" },
                            { icon: "⚡", label: "Cấu hình sạc" },
                            { icon: "🔒", label: "Bảo mật" },
                            { icon: "📡", label: "OCPP" },
                            { icon: "🔧", label: "Công cụ" },
                            { icon: "ℹ️", label: "Thông tin hệ thống" }
                        ]

                        Rectangle {
                            width: 200; height: 44
                            radius: 8
                            color: selectedSection === index ? Qt.rgba(0, 1, 136 / 255, 0.1) : "transparent"

                            Row {
                                anchors.fill: parent
                                anchors.leftMargin: 14
                                spacing: 10

                                Text {
                                    text: modelData.icon
                                    font.pixelSize: 14
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {
                                    text: modelData.label
                                    color: selectedSection === index ? Theme.textPrimary : Theme.textSecondary
                                    font.pixelSize: 12
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            Rectangle {
                                anchors.left: parent.left
                                width: 3
                                height: parent.height
                                radius: 2
                                color: Theme.primary
                                visible: selectedSection === index
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: selectedSection = index
                            }
                        }
                    }
                }

                Rectangle {
                    width: 1; height: parent.height
                    color: Theme.textMuted
                    opacity: 0.2
                }

                // Main settings content
                Flickable {
                    width: 760
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    contentHeight: settingsContent.height + 40
                    clip: true

                    Column {
                        id: settingsContent
                        spacing: 20
                        width: 720
                        anchors.leftMargin: 24

                        // Screen & UI section
                        Column {
                            spacing: 10
                            visible: selectedSection === 0

                            Text {
                                text: "Màn hình & Giao diện"
                                color: Theme.textPrimary
                                font.pixelSize: 16
                                font.bold: true
                            }

                            // Brightness slider
                            Rectangle {
                                width: 720; height: 52
                                radius: 10
                                color: Theme.bgCard
                                border.color: Theme.textMuted
                                border.width: 1

                                Row {
                                    anchors.fill: parent
                                    anchors.margins: 16
                                    spacing: 12

                                    Text {
                                        text: "Độ sáng màn hình"
                                        color: Theme.textPrimary
                                        font.pixelSize: 13
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Item { Layout.fillWidth: true }

                                    Rectangle {
                                        width: 160; height: 5
                                        radius: 3
                                        color: Theme.bgLight
                                        anchors.verticalCenter: parent.verticalCenter

                                        Rectangle {
                                            width: 160 * brightnessValue / 100
                                            height: 5
                                            radius: 3
                                            color: Theme.primary
                                        }
                                    }

                                    Text {
                                        text: brightnessValue + "%"
                                        color: Theme.textSecondary
                                        font.pixelSize: 11
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        brightnessValue = Math.min(100, Math.max(10, brightnessValue + 10))
                                    }
                                }
                            }

                            // Toggle row
                            Rectangle {
                                width: 720; height: 52
                                radius: 10
                                color: Theme.bgCard
                                border.color: Theme.textMuted
                                border.width: 1

                                Row {
                                    anchors.fill: parent
                                    anchors.margins: 16
                                    spacing: 12

                                    Text {
                                        text: "Tự động giảm độ sáng"
                                        color: Theme.textPrimary
                                        font.pixelSize: 13
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Item { Layout.fillWidth: true }

                                    Rectangle {
                                        width: 40; height: 22
                                        radius: 11
                                        color: Theme.primary
                                        anchors.verticalCenter: parent.verticalCenter

                                        Rectangle {
                                            anchors.left: parent.left
                                            anchors.leftMargin: 3
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 18; height: 18
                                            radius: 9
                                            color: "#ffffff"
                                        }
                                    }
                                }
                            }
                        }

                        // Network section
                        Column {
                            spacing: 10
                            visible: selectedSection === 1

                            Text {
                                text: "Kết nối mạng"
                                color: Theme.textPrimary
                                font.pixelSize: 16
                                font.bold: true
                            }

                            Rectangle {
                                width: 720; height: 160
                                radius: 10
                                color: Theme.bgCard
                                border.color: Theme.primary
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 20
                                    spacing: 12

                                    Row {
                                        spacing: 12
                                        Text { text: "📶"; font.pixelSize: 20 }
                                        Text { text: "Wi-Fi 6"; color: Theme.textPrimary; font.pixelSize: 14; font.bold: true }
                                        Rectangle { width: 8; height: 8; radius: 4; color: Theme.primary; anchors.verticalCenter: parent.verticalCenter }
                                        Text { text: "Kết nối"; color: Theme.primary; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                                    }

                                    Grid {
                                        columns: 2
                                        columnSpacing: 24
                                        rowSpacing: 8

                                        Column { spacing: 2
                                            Text { text: "SSID"; color: Theme.textMuted; font.pixelSize: 11 }
                                            Text { text: "GETECH-EVSE-5G"; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true }
                                        }
                                        Column { spacing: 2
                                            Text { text: "IP Address"; color: Theme.textMuted; font.pixelSize: 11 }
                                            Text { text: "192.168.1.100"; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true }
                                        }
                                        Column { spacing: 2
                                            Text { text: "MAC Address"; color: Theme.textMuted; font.pixelSize: 11 }
                                            Text { text: "00:1A:2B:3C:4D:5E"; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true }
                                        }
                                        Column { spacing: 2
                                            Text { text: "Signal Strength"; color: Theme.textMuted; font.pixelSize: 11 }
                                            Text { text: "Tuyệt vời (-45 dBm)"; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true }
                                        }
                                    }

                                    Item { Layout.fillHeight: true }

                                    Row {
                                        spacing: 8
                                        Rectangle {
                                            width: 120; height: 32; radius: 16
                                            color: Theme.primary
                                            Text { anchors.centerIn: parent; text: "Quét lại"; color: "#0D1117"; font.pixelSize: 12; font.bold: true }
                                        }
                                        Rectangle {
                                            width: 120; height: 32; radius: 16
                                            color: Theme.bgLight
                                            Text { anchors.centerIn: parent; text: "Cài đặt"; color: Theme.textSecondary; font.pixelSize: 12 }
                                        }
                                    }
                                }
                            }
                        }

                        // Charging config section
                        Column {
                            spacing: 10
                            visible: selectedSection === 2

                            Text {
                                text: "Cấu hình sạc"
                                color: Theme.textPrimary
                                font.pixelSize: 16
                                font.bold: true
                            }

                            Rectangle {
                                width: 720; height: 280
                                radius: 10
                                color: Theme.bgCard
                                border.color: Theme.textMuted
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 20
                                    spacing: 16

                                    Text { text: "Cấu hình đầu sạc A (CCS2)"; color: Theme.textPrimary; font.pixelSize: 14; font.bold: true }

                                    Grid {
                                        columns: 2
                                        columnSpacing: 12
                                        rowSpacing: 8

                                        Repeater {
                                            model: [
                                                { label: "Công suất tối đa", value: "120 kW" },
                                                { label: "Dòng sạc tối đa", value: "250 A" },
                                                { label: "Điện áp tối đa", value: "500 V" },
                                                { label: "Giao thức sạc", value: "ISO 15118-2" },
                                                { label: "Đơn giá AC", value: "3.500 đ/kWh" },
                                                { label: "Đơn giá DC", value: "9.500 đ/kWh" },
                                                { label: "Phí khởi tạo", value: "30.000 đ" },
                                                { label: "Giới hạn SOC", value: "100%" }
                                            ]

                                            Rectangle {
                                                radius: 7
                                                color: Theme.bgLight
                                                height: 44
                                                Layout.fillWidth: true

                                                Column {
                                                    anchors.centerIn: parent
                                                    spacing: 2
                                                    Text { text: modelData.label; color: Theme.textMuted; font.pixelSize: 11 }
                                                    Text { text: modelData.value; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true }
                                                }
                                            }
                                        }
                                    }

                                    Item { Layout.fillHeight: true }

                                    Row {
                                        spacing: 8
                                        Rectangle {
                                            width: 140; height: 36; radius: 18
                                            color: Theme.primary
                                            Text { anchors.centerIn: parent; text: "Lưu cấu hình"; color: "#0D1117"; font.pixelSize: 13; font.bold: true }
                                        }
                                        Rectangle {
                                            width: 140; height: 36; radius: 18
                                            color: Theme.bgLight
                                            Text { anchors.centerIn: parent; text: "Khôi phục mặc định"; color: Theme.textSecondary; font.pixelSize: 12 }
                                        }
                                    }
                                }
                            }
                        }

                        // OCPP section
                        Column {
                            spacing: 10
                            visible: selectedSection === 4

                            Text {
                                text: "OCPP 1.6J Configuration"
                                color: Theme.textPrimary
                                font.pixelSize: 16
                                font.bold: true
                            }

                            Rectangle {
                                width: 720; height: 220
                                radius: 10
                                color: Theme.bgCard
                                border.color: backend.ocppConnected ? Theme.primary : Theme.statusError
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 20
                                    spacing: 12

                                    Row {
                                        spacing: 12
                                        Text { text: backend.ocppConnected ? "✓" : "✗"; font.pixelSize: 20; color: backend.ocppConnected ? Theme.statusReady : Theme.statusError }
                                        Text { text: backend.ocppConnected ? "Đã kết nối CSMS" : "Mất kết nối CSMS"; color: Theme.textPrimary; font.pixelSize: 14; font.bold: true }
                                        Item { Layout.fillWidth: true }
                                        Rectangle {
                                            height: 28; radius: 14
                                            color: backend.ocppConnected ? "#0d2818" : "#2d1515"
                                            width: 80
                                            Text { anchors.centerIn: parent; text: backend.ocppConnected ? "Online" : "Offline"; color: backend.ocppConnected ? Theme.primary : Theme.statusError; font.pixelSize: 11; font.bold: true }
                                        }
                                    }

                                    Grid {
                                        columns: 2
                                        columnSpacing: 24
                                        rowSpacing: 8

                                        Repeater {
                                            model: [
                                                { label: "CSMS URL", value: backend.ocpp.csmsUrl },
                                                { label: "Charge Box ID", value: backend.ocpp.chargeBoxId },
                                                { label: "Protocol", value: backend.ocpp.protocol },
                                                { label: "Heartbeat interval", value: backend.ocpp.heartbeatInterval + "s" }
                                            ]

                                            Column { spacing: 2
                                                Text { text: modelData.label; color: Theme.textMuted; font.pixelSize: 11 }
                                                Text { text: modelData.value; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true }
                                            }
                                        }
                                    }

                                    Item { Layout.fillHeight: true }

                                    Row {
                                        spacing: 8
                                        Rectangle {
                                            width: 130; height: 32; radius: 16
                                            color: Theme.bgLight
                                            Text { anchors.centerIn: parent; text: "Kiểm tra kết nối"; color: Theme.textSecondary; font.pixelSize: 12 }
                                        }
                                        Rectangle {
                                            width: 130; height: 32; radius: 16
                                            color: Theme.bgLight
                                            Text { anchors.centerIn: parent; text: "Cấu hình lại"; color: Theme.textSecondary; font.pixelSize: 12 }
                                        }
                                    }
                                }
                            }
                        }

                        // System Info section
                        Column {
                            spacing: 10
                            visible: selectedSection === 6

                            Text {
                                text: "Thông tin hệ thống"
                                color: Theme.textPrimary
                                font.pixelSize: 16
                                font.bold: true
                            }

                            Rectangle {
                                width: 720; height: 280
                                radius: 10
                                color: Theme.bgCard
                                border.color: Theme.textMuted
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 20
                                    spacing: 16

                                    Row {
                                        spacing: 20

                                        Rectangle {
                                            width: 64; height: 64
                                            radius: 12
                                            color: Theme.primary

                                            Text {
                                                anchors.centerIn: parent
                                                text: "E"
                                                color: "#0D1117"
                                                font.pixelSize: 32
                                                font.bold: true
                                            }
                                        }

                                        Column {
                                            spacing: 4
                                            anchors.verticalCenter: parent.verticalCenter

                                            Text {
                                                text: "EasyEVSE EV Charger"
                                                color: Theme.textPrimary
                                                font.pixelSize: 18
                                                font.bold: true
                                            }
                                            Text {
                                                text: "i.MX 93 EVSE Platform • NXP"
                                                color: Theme.textMuted
                                                font.pixelSize: 12
                                            }
                                        }
                                    }

                                    Grid {
                                        columns: 3
                                        columnSpacing: 16
                                        rowSpacing: 10

                                        Repeater {
                                            model: [
                                                { label: "Hardware", value: "EVSE-IMX93" },
                                                { label: "Firmware", value: "v2.4.1" },
                                                { label: "Kernel", value: "Linux 5.15" },
                                                { label: "Display", value: "DY1212W-4856 (12.1\")" },
                                                { label: "Security", value: "EdgeLock SE050" },
                                                { label: "Meter", value: "NXP KM35x" },
                                                { label: "NFC", value: "PN7160" },
                                                { label: "Wi-Fi", value: "Murata IW612 (Wi-Fi 6)" },
                                                { label: "Serial", value: "NXP-2025-GT-001" }
                                            ]

                                            Column { spacing: 2
                                                Text { text: modelData.label; color: Theme.textMuted; font.pixelSize: 11 }
                                                Text { text: modelData.value; color: Theme.textPrimary; font.pixelSize: 12; font.bold: true }
                                            }
                                        }
                                    }

                                    Item { Layout.fillHeight: true }

                                    Text {
                                        text: "© 2026 EasyEVSE • EV Charging Solutions • NXP EasyEVSE Platform"
                                        color: Theme.textMuted
                                        font.pixelSize: 10
                                        Layout.alignment: Qt.AlignHCenter
                                    }
                                }
                            }
                        }

                        // Placeholder sections
                        Column {
                            spacing: 10
                            visible: selectedSection === 3 || selectedSection === 5

                            Text {
                                text: selectedSection === 3 ? "Bảo mật" : "Công cụ"
                                color: Theme.textPrimary
                                font.pixelSize: 16
                                font.bold: true
                            }

                            Rectangle {
                                width: 720; height: 120
                                radius: 10
                                color: Theme.bgCard
                                border.color: Theme.textMuted
                                border.width: 1

                                Column {
                                    anchors.centerIn: parent
                                    spacing: 8

                                    Text {
                                        text: "⚙️"
                                        font.pixelSize: 32
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }

                                    Text {
                                        text: selectedSection === 3 ? "Cấu hình bảo mật sẽ sớm có" : "Công cụ chẩn đoán sẽ sớm có"
                                        color: Theme.textMuted
                                        font.pixelSize: 14
                                        anchors.horizontalCenter: parent.horizontalCenter
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
