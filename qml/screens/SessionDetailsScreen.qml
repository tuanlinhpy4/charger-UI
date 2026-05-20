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

        // Section header
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 52
            color: Theme.bgMedium

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 12

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

                    Text {
                        text: "Chi tiết phiên sạc"
                        color: Theme.textPrimary
                        font.pixelSize: 15
                        font.bold: true
                    }

                    Text {
                        text: "#EV802341 • " + currentPort.name
                        color: Theme.textMuted
                        font.pixelSize: 10
                    }
                }

                Item { Layout.fillWidth: true }

                Rectangle {
                    Layout.preferredWidth: sessionStatusRow.implicitWidth + 24
                    Layout.preferredHeight: 24
                    Layout.alignment: Qt.AlignVCenter
                    radius: 12
                    color: currentPort.state === 1 ? "#0D1F3C" : "#2D1F08"

                    Row {
                        id: sessionStatusRow
                        anchors.centerIn: parent
                        spacing: 5

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 7; height: 7; radius: 4
                            color: currentPort.state === 1 ? Theme.statusCharging : Theme.statusDone
                        }

                        Text {
                            text: currentPort.state === 1 ? "ĐANG SẠC" : "HOÀN THÀNH"
                            color: currentPort.state === 1 ? Theme.statusCharging : Theme.statusDone
                            font.pixelSize: 10
                            font.bold: true
                            anchors.verticalCenter: parent.verticalCenter
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

        // Main content
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Row {
                anchors.fill: parent
                anchors.margins: 24
                spacing: 20

                // Left column
                Column {
                    spacing: 14
                    width: 340
                    anchors.verticalCenter: parent.verticalCenter

                    // Session card
                    Rectangle {
                        width: 340
                        height: 150
                        radius: 12
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 12

                            Row {
                                Layout.fillWidth: true
                                spacing: 20

                                Column { spacing: 2
                                    Text { text: "Mã phiên"; color: Theme.textMuted; font.pixelSize: 10 }
                                    Text { text: "#EV802341"; color: Theme.textPrimary; font.pixelSize: 14; font.bold: true }
                                }

                                Column { spacing: 2
                                    Text { text: "Ngày"; color: Theme.textMuted; font.pixelSize: 10 }
                                    Text { text: "12/05/2026"; color: Theme.textPrimary; font.pixelSize: 14; font.bold: true }
                                }

                                Column { spacing: 2
                                    Text { text: "Bắt đầu"; color: Theme.textMuted; font.pixelSize: 10 }
                                    Text { text: "14:04:30"; color: Theme.textPrimary; font.pixelSize: 14; font.bold: true }
                                }
                            }

                            // KPI row
                            Row {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 56
                                spacing: 0

                                Rectangle {
                                    width: parent.width / 3
                                    height: parent.height
                                    color: Theme.bgLight
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Điện năng"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: currentPort.energyDelivered.toFixed(3) + " kWh"; color: Theme.accent; font.pixelSize: 13; font.bold: true }
                                    }
                                }

                                Rectangle {
                                    width: parent.width / 3
                                    height: parent.height
                                    color: Theme.bgLight
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Thời gian"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text {
                                            text: Theme.formatTime(currentPort.elapsedSeconds)
                                            color: Theme.textPrimary; font.pixelSize: 13; font.bold: true
                                        }
                                    }
                                }

                                Rectangle {
                                    width: parent.width / 3
                                    height: parent.height
                                    color: Theme.bgLight
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "CS TB"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text {
                                            text: currentPort.elapsedSeconds > 0 ? (currentPort.energyDelivered / (currentPort.elapsedSeconds / 3600)).toFixed(1) + " kW" : "—"
                                            color: Theme.statusCharging; font.pixelSize: 13; font.bold: true
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Energy report
                    Rectangle {
                        width: 340
                        height: 150
                        radius: 12
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 12

                            Text {
                                text: "Báo cáo năng lượng"
                                color: Theme.textSecondary
                                font.pixelSize: 12
                            }

                            Row {
                                spacing: 8
                                Layout.fillWidth: true

                                Column { spacing: 4
                                    Text { text: "SOC ban đầu"; color: Theme.textMuted; font.pixelSize: 11 }
                                    Rectangle {
                                        width: 140; height: 12
                                        radius: 6
                                        color: Theme.bgLight
                                        Rectangle {
                                            anchors.left: parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            height: parent.height - 4
                                            width: (parent.width - 4) * 0.42
                                            radius: 4
                                            color: Theme.textSecondary
                                        }
                                    }
                                    Text { text: "42%"; color: Theme.textSecondary; font.pixelSize: 13; font.bold: true }
                                }

                                Column { spacing: 4
                                    Text { text: "SOC kết thúc"; color: Theme.textMuted; font.pixelSize: 11 }
                                    Rectangle {
                                        width: 140; height: 12
                                        radius: 6
                                        color: Theme.bgLight
                                        Rectangle {
                                            anchors.left: parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            height: parent.height - 4
                                            width: (parent.width - 4) * currentPort.batteryPercent / 100.0
                                            radius: 4
                                            color: Theme.statusCharging
                                        }
                                    }
                                    Text {
                                        text: Math.floor(currentPort.batteryPercent) + "%"
                                        color: Theme.statusCharging; font.pixelSize: 13; font.bold: true
                                    }
                                }
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                Text { text: "Tổng tăng pin"; color: Theme.textSecondary; font.pixelSize: 11 }
                                Item { Layout.fillWidth: true }
                                Text {
                                    text: "+" + Math.floor(currentPort.batteryPercent - 42) + "%"
                                    color: Theme.primary; font.pixelSize: 13; font.bold: true
                                }
                            }

                            Item { Layout.fillHeight: true }
                        }
                    }

                    // QR receipt
                    Rectangle {
                        width: 340
                        height: 150
                        radius: 12
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 10

                            Text {
                                text: "Mã hóa đơn"
                                color: Theme.textMuted
                                font.pixelSize: 11
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Rectangle {
                                width: 80; height: 80
                                radius: 8
                                color: "#ffffff"
                                Layout.alignment: Qt.AlignHCenter

                                Column {
                                    anchors.centerIn: parent
                                    spacing: 2
                                    Repeater {
                                        model: 8
                                        Row {
                                            spacing: 2
                                            Repeater {
                                                model: 8
                                                Rectangle {
                                                    width: 7; height: 7
                                                    color: (index % 2 === 0 && modelData % 2 === 0) ||
                                                           (index % 2 === 1 && modelData % 2 === 1) ? "#0D1117" : "#ffffff"
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Text {
                                text: "QR để tải hóa đơn chi tiết"
                                color: Theme.textMuted
                                font.pixelSize: 10
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }

                // Right column
                Column {
                    spacing: 14
                    width: 580
                    anchors.verticalCenter: parent.verticalCenter

                    // Technical specs
                    Rectangle {
                        width: 580
                        height: 230
                        radius: 12
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 12

                            Text {
                                text: "Thông số kỹ thuật"
                                color: Theme.textSecondary
                                font.pixelSize: 12
                            }

                            Grid {
                                width: parent.width
                                columns: 2
                                columnSpacing: 8
                                rowSpacing: 8
                                Layout.fillWidth: true

                                Repeater {
                                    model: [
                                        "Đầu nối",
                                        "Giao thức",
                                        "Công suất TB",
                                        "Dòng điện TB",
                                        "Điện áp TB",
                                        "Thời gian sạc",
                                        "Mã ID xe",
                                        "OCPP"
                                    ]

                                    Rectangle {
                                        width: (parent.width - parent.columnSpacing) / 2
                                        radius: 8
                                        color: Theme.bgLight
                                        height: 36

                                        Column {
                                            anchors.centerIn: parent
                                            spacing: 2
                                            Text { text: modelData; color: Theme.textMuted; font.pixelSize: 9 }
                                            Text {
                                                text: index === 0 ? "CCS2" :
                                                      index === 1 ? "ISO 15118-2" :
                                                      index === 2 ? (currentPort.elapsedSeconds > 0 ? (currentPort.energyDelivered / (currentPort.elapsedSeconds / 3600)).toFixed(1) + " kW" : "—") :
                                                      index === 3 ? (currentPort.currentPower > 0 ? (currentPort.currentPower / 400 * 1000).toFixed(1) + " A" : "—") :
                                                      index === 4 ? "400.0 V" :
                                                      index === 5 ? Theme.formatTime(currentPort.elapsedSeconds) :
                                                      index === 6 ? "••••••••" :
                                                      backend.ocppConnected ? "1.6J Online" : "Offline"
                                                color: Theme.textPrimary
                                                font.pixelSize: 11
                                                font.bold: true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Cost breakdown
                    Rectangle {
                        width: 580
                        height: 190
                        radius: 12
                        color: Theme.bgCard
                        border.color: Theme.statusDone
                        border.width: 2

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 10

                            Text {
                                text: "Chi tiết chi phí"
                                color: Theme.textPrimary
                                font.pixelSize: 14
                                font.bold: true
                            }

                            Rectangle {
                                radius: 6
                                color: Theme.bgLight
                                Layout.preferredHeight: 36
                                Layout.fillWidth: true

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10

                                    Text { text: "Phí năng lượng"; color: Theme.textSecondary; font.pixelSize: 12; Layout.alignment: Qt.AlignVCenter }
                                    Item { Layout.fillWidth: true }
                                    Text { text: (currentPort.energyDelivered * 3500).toLocaleString('vi-VN') + " đ"; color: Theme.textPrimary; font.pixelSize: 12; font.bold: true; Layout.alignment: Qt.AlignVCenter }
                                }
                            }

                            Rectangle {
                                radius: 6
                                color: Theme.bgLight
                                Layout.preferredHeight: 36
                                Layout.fillWidth: true

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10

                                    Text { text: "Phí dịch vụ"; color: Theme.textSecondary; font.pixelSize: 12; Layout.alignment: Qt.AlignVCenter }
                                    Item { Layout.fillWidth: true }
                                    Text { text: "30.000 đ"; color: Theme.textPrimary; font.pixelSize: 12; font.bold: true; Layout.alignment: Qt.AlignVCenter }
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 2
                                color: Theme.statusDone
                            }

                            RowLayout {
                                Layout.fillWidth: true

                                Text { text: "TỔNG CỘNG"; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true }
                                Item { Layout.fillWidth: true }
                                Text {
                                    text: (currentPort.energyDelivered * 3500 + 30000).toLocaleString('vi-VN') + " đ"
                                    color: Theme.statusDone; font.pixelSize: 15; font.bold: true
                                }
                            }
                        }
                    }

                    // Meter
                    Rectangle {
                        width: 580
                        height: 140
                        radius: 12
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 10

                            Text {
                                text: "Công tơ đo (Metrology — TWR-KM35Z75M)"
                                color: Theme.textSecondary
                                font.pixelSize: 12
                            }

                            Row {
                                spacing: 8
                                Layout.alignment: Qt.AlignHCenter

                                Rectangle {
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 52
                                    width: 140

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 4
                                        Text { text: "Điện năng"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: currentPort.energyDelivered.toFixed(3) + " kWh"; color: Theme.accent; font.pixelSize: 11; font.bold: true }
                                    }
                                }

                                Rectangle {
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 52
                                    width: 140

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 4
                                        Text { text: "Công suất"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: currentPort.currentPower.toFixed(1) + " kW"; color: Theme.accent; font.pixelSize: 11; font.bold: true }
                                    }
                                }

                                Rectangle {
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 52
                                    width: 140

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 4
                                        Text { text: "Hệ số PF"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: "0.99"; color: Theme.accent; font.pixelSize: 11; font.bold: true }
                                    }
                                }
                            }

                            Text {
                                text: "✓ Đã hiệu chuẩn | ✓ Giao thức MID | ✓ Niêm phong metrology"
                                color: Theme.textMuted
                                font.pixelSize: 9
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    // Pay button
                    Rectangle {
                        width: 580
                        height: 48
                        radius: 24
                        color: Theme.statusDone

                        Text {
                            anchors.centerIn: parent
                            text: "💳 Thanh toán " + (currentPort.energyDelivered * 3500 + 30000).toLocaleString('vi-VN') + " đ"
                            color: "#ffffff"
                            font.pixelSize: 14
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: screenSelect("payment", selectedPort)
                        }
                    }
                }
            }
        }
    }

    signal screenSelect(string screen, string port)
}
