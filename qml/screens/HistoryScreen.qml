import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Rectangle {
    id: root
    color: Theme.bgDark

    property int filterMode: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 0

        // Header
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
                        onClicked: screenSelect("home", "A")
                    }
                }

                Text {
                    text: "Lịch sử sạc"
                    color: Theme.textPrimary
                    font.pixelSize: 17
                    font.bold: true
                    Layout.alignment: Qt.AlignVCenter
                }

                Item { Layout.fillWidth: true }

                // Filter tabs
                Row {
                    spacing: 4
                    Layout.alignment: Qt.AlignVCenter

                    Repeater {
                        model: ["Tất cả", "Hôm nay", "Tuần này", "Tháng này"]

                        Rectangle {
                            width: filterText.width + 20; height: 32
                            radius: 8
                            color: filterMode === index ? Theme.primary : Theme.bgLight
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                                id: filterText
                                anchors.centerIn: parent
                                anchors.margins: 10
                                text: modelData
                                color: filterMode === index ? "#0D1117" : Theme.textSecondary
                                font.pixelSize: 11
                                font.bold: filterMode === index
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: filterMode = index
                            }
                        }
                    }
                }

                // Stats
                Row {
                    spacing: 16
                    Layout.alignment: Qt.AlignVCenter

                    Column { spacing: 2
                        Text { text: "Tổng phiên"; color: Theme.textMuted; font.pixelSize: 10 }
                        Text { text: "47 phiên"; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true }
                    }

                    Column { spacing: 2
                        Text { text: "Tổng năng lượng"; color: Theme.textMuted; font.pixelSize: 10 }
                        Text { text: "1.284 kWh"; color: Theme.accent; font.pixelSize: 13; font.bold: true }
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

        // Table header
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Layout.leftMargin: 24
            Layout.rightMargin: 24
            Layout.topMargin: 16
            color: Theme.bgLight
            radius: 8

            Row {
                anchors.fill: parent
                anchors.leftMargin: 14
                anchors.rightMargin: 14

                spacing: 0

                Rectangle { width: 14; height: parent.height; color: "transparent" }
                Rectangle { width: 140; height: parent.height; color: "transparent"
                    Text { anchors.verticalCenter: parent.verticalCenter; text: "Ngày / Giờ"; color: Theme.textMuted; font.pixelSize: 10; font.bold: true }
                }
                Rectangle { width: 120; height: parent.height; color: "transparent"
                    Text { anchors.verticalCenter: parent.verticalCenter; text: "Cổng sạc"; color: Theme.textMuted; font.pixelSize: 10; font.bold: true }
                }
                Rectangle { width: 100; height: parent.height; color: "transparent"
                    Text { anchors.verticalCenter: parent.verticalCenter; text: "Năng lượng"; color: Theme.textMuted; font.pixelSize: 10; font.bold: true }
                }
                Rectangle { width: 90; height: parent.height; color: "transparent"
                    Text { anchors.verticalCenter: parent.verticalCenter; text: "Thời gian"; color: Theme.textMuted; font.pixelSize: 10; font.bold: true }
                }
                Rectangle { width: 90; height: parent.height; color: "transparent"
                    Text { anchors.verticalCenter: parent.verticalCenter; text: "Công suất"; color: Theme.textMuted; font.pixelSize: 10; font.bold: true }
                }
                Rectangle { width: 140; height: parent.height; color: "transparent"
                    Text { anchors.verticalCenter: parent.verticalCenter; text: "Thành tiền"; color: Theme.textMuted; font.pixelSize: 10; font.bold: true }
                }
                Rectangle { width: 80; height: parent.height; color: "transparent"
                    Text { anchors.verticalCenter: parent.verticalCenter; text: "Trạng thái"; color: Theme.textMuted; font.pixelSize: 10; font.bold: true }
                }
            }
        }

        // Divider
        Rectangle {
            Layout.fillWidth: true
            Layout.leftMargin: 24
            Layout.rightMargin: 24
            Layout.preferredHeight: 1
            color: Theme.textMuted
            opacity: 0.2
        }

        // Session list
        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 24
            Layout.rightMargin: 24
            Layout.bottomMargin: 16
            spacing: 4
            clip: true

            model: ListModel {
                id: historyModel
                ListElement {
                    date: "12/05/2026 14:32"
                    port: "Đầu sạc A"
                    energy: "32.450"
                    duration: "00:28:15"
                    power: "68.2 kW"
                    cost: "143.575"
                    status: "Hoàn thành"
                    statusColor: "#9E6A03"
                }
                ListElement {
                    date: "12/05/2026 10:15"
                    port: "Đầu sạc B"
                    energy: "18.200"
                    duration: "00:15:40"
                    power: "69.6 kW"
                    cost: "93.700"
                    status: "Hoàn thành"
                    statusColor: "#9E6A03"
                }
                ListElement {
                    date: "11/05/2026 18:45"
                    port: "Đầu sạc A"
                    energy: "45.100"
                    duration: "00:42:00"
                    power: "64.4 kW"
                    cost: "187.850"
                    status: "Hoàn thành"
                    statusColor: "#9E6A03"
                }
                ListElement {
                    date: "11/05/2026 09:20"
                    port: "Đầu sạc A"
                    energy: "28.750"
                    duration: "00:25:10"
                    power: "68.5 kW"
                    cost: "130.625"
                    status: "Hoàn thành"
                    statusColor: "#9E6A03"
                }
                ListElement {
                    date: "10/05/2026 22:10"
                    port: "Đầu sạc B"
                    energy: "52.300"
                    duration: "00:48:30"
                    power: "64.7 kW"
                    cost: "213.050"
                    status: "Hoàn thành"
                    statusColor: "#9E6A03"
                }
                ListElement {
                    date: "10/05/2026 16:00"
                    port: "Đầu sạc A"
                    energy: "0"
                    duration: "00:02:00"
                    power: "0 kW"
                    cost: "30.000"
                    status: "Đã hủy"
                    statusColor: "#484F58"
                }
                ListElement {
                    date: "09/05/2026 11:30"
                    port: "Đầu sạc A"
                    energy: "38.900"
                    duration: "00:35:45"
                    power: "65.3 kW"
                    cost: "166.150"
                    status: "Hoàn thành"
                    statusColor: "#9E6A03"
                }
            }

            delegate: Rectangle {
                width: parent ? parent.width : 1000
                height: 48
                radius: 6
                color: Theme.bgCard
                border.color: Theme.textMuted
                border.width: 1

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 14
                    spacing: 0

                    Rectangle { width: 14; height: 14; radius: 7; color: statusColor; anchors.verticalCenter: parent.verticalCenter }

                    Rectangle { width: 126; height: parent.height; color: "transparent"
                        Text { anchors.verticalCenter: parent.verticalCenter; text: date; color: Theme.textPrimary; font.pixelSize: 11 }
                    }
                    Rectangle { width: 120; height: parent.height; color: "transparent"
                        Text { anchors.verticalCenter: parent.verticalCenter; text: port; color: Theme.textPrimary; font.pixelSize: 11 }
                    }
                    Rectangle { width: 100; height: parent.height; color: "transparent"
                        Text { anchors.verticalCenter: parent.verticalCenter; text: energy + " kWh"; color: Theme.accent; font.pixelSize: 11; font.bold: true }
                    }
                    Rectangle { width: 90; height: parent.height; color: "transparent"
                        Text { anchors.verticalCenter: parent.verticalCenter; text: duration; color: Theme.textSecondary; font.pixelSize: 11 }
                    }
                    Rectangle { width: 90; height: parent.height; color: "transparent"
                        Text { anchors.verticalCenter: parent.verticalCenter; text: power; color: Theme.textPrimary; font.pixelSize: 11 }
                    }
                    Rectangle { width: 140; height: parent.height; color: "transparent"
                        Text { anchors.verticalCenter: parent.verticalCenter; text: parseInt(cost).toLocaleString('vi-VN') + " đ"; color: Theme.statusDone; font.pixelSize: 11; font.bold: true }
                    }
                    Rectangle { width: 80; height: parent.height; color: "transparent"
                        Text { anchors.verticalCenter: parent.verticalCenter; text: status; color: statusColor; font.pixelSize: 10; font.bold: true }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                }
            }
        }
    }

    signal screenSelect(string screen, string port)
}
