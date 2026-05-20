import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    property bool compact: height < 220

    property string portName: "Đầu sạc A"
    property string connectorType: "CCS2"
    property int maxPower: 120
    property int state: 0
    property double batteryPercent: 0
    property double energyDelivered: 0
    property double currentPower: 0
    property int elapsedSeconds: 0

    signal selected()
    signal detailsClicked()

    function stateText(s) {
        switch (s) {
        case 0: return "SẴN SÀNG"
        case 1: return "ĐANG SẠC"
        case 2: return "HOÀN THÀNH"
        case 3: return "LỖI"
        case 4: return "ĐÃ KHÓA"
        case 5: return "CHỜ XÁC THỰC"
        default: return ""
        }
    }

    function stateColor(s) {
        switch (s) {
        case 0: return Theme.statusReady
        case 1: return Theme.statusCharging
        case 2: return Theme.statusDone
        case 3: return Theme.statusError
        case 4: return Theme.statusOffline
        case 5: return Theme.accent
        default: return Theme.statusOffline
        }
    }

    function displayBattery() {
        return root.state === 0 ? "--" : Math.floor(root.batteryPercent) + "%"
    }

    function displayTime() {
        return root.state === 0 ? "--:--:--" : Theme.formatTime(root.elapsedSeconds)
    }

    function displayCost() {
        return root.state === 0 ? "0 đ" : Math.round(root.energyDelivered * 3500).toLocaleString("vi-VN") + " đ"
    }

    Rectangle {
        id: card
        anchors.fill: parent
        radius: 14
        color: Theme.bgCard
        border.color: root.state === 1 ? Theme.statusCharging : (root.state === 3 ? Theme.statusError : Theme.textMuted)
        border.width: 1

        MouseArea {
            anchors.fill: parent
            onClicked: root.selected()
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: root.compact ? 10 : 16
            spacing: root.compact ? 5 : 8

            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Rectangle {
                    width: 10
                    height: 10
                    radius: 5
                    color: root.stateColor(root.state)
                    Layout.alignment: Qt.AlignVCenter
                }

                Text {
                    text: root.portName
                    color: Theme.textPrimary
                    font.pixelSize: root.compact ? 13 : 16
                    font.bold: true
                    Layout.alignment: Qt.AlignVCenter
                }

                Rectangle {
                    height: 20
                    radius: 10
                    color: Theme.bgLight
                    Layout.alignment: Qt.AlignVCenter
                    implicitWidth: connectorText.implicitWidth + 20

                    Text {
                        id: connectorText
                        anchors.centerIn: parent
                        text: root.connectorType
                        color: Theme.textSecondary
                        font.pixelSize: 10
                        font.bold: true
                    }
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: root.maxPower + " kW"
                    color: Theme.accent
                    font.pixelSize: root.compact ? 10 : 12
                    font.bold: true
                    Layout.alignment: Qt.AlignVCenter
                }
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: statusText.implicitWidth + 28
                height: root.compact ? 20 : 24
                radius: 12
                color: root.stateColor(root.state)

                Text {
                    id: statusText
                    anchors.centerIn: parent
                    text: root.stateText(root.state)
                    color: "#ffffff"
                    font.pixelSize: root.compact ? 9 : 10
                    font.bold: true
                }
            }

            Item {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: root.compact ? 48 : 72
                Layout.preferredHeight: root.compact ? 42 : 96

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: root.compact ? 30 : 50
                    height: root.compact ? 36 : 78
                    radius: 5
                    color: "transparent"
                    border.color: Theme.textMuted
                    border.width: 2
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: root.compact ? 24 : 42
                    height: root.state === 0 ? 0 : Math.max(4, (root.compact ? 30 : 72) * root.batteryPercent / 100.0)
                    radius: 3
                    color: root.state === 1 ? Theme.statusCharging : root.stateColor(root.state)
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: root.compact ? 39 : 81
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: root.compact ? 14 : 20
                    height: root.compact ? 4 : 5
                    radius: 2
                    color: Theme.textMuted
                }

                Text {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: root.compact ? 3 : 8
                    text: root.displayBattery()
                    color: "#ffffff"
                    font.pixelSize: root.compact ? 10 : 15
                    font.bold: true
                }

                Text {
                    visible: !root.compact
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    text: "⚡"
                    color: root.state === 1 ? Theme.primary : root.stateColor(root.state)
                    font.pixelSize: 13
                }
            }

            Grid {
                Layout.fillWidth: true
                Layout.preferredHeight: root.compact ? 40 : 56
                columns: 2
                columnSpacing: root.compact ? 10 : 16
                rowSpacing: root.compact ? 2 : 4

                Repeater {
                    model: ["Năng lượng", "Công suất", "Thời gian", "Giá"]

                    Column {
                        width: (parent.width - parent.columnSpacing) / 2
                        height: root.compact ? 18 : 24
                        spacing: 1

                        Text {
                            text: modelData
                            color: Theme.textMuted
                            font.pixelSize: root.compact ? 8 : 9
                        }

                        Text {
                            text: index === 0 ? root.energyDelivered.toFixed(2) + " kWh" :
                                  index === 1 ? root.currentPower.toFixed(1) + " kW" :
                                  index === 2 ? root.displayTime() :
                                  root.displayCost()
                            color: Theme.textPrimary
                            font.pixelSize: root.compact ? 9 : 11
                            font.bold: true
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: root.compact ? 28 : 34
                spacing: root.compact ? 6 : 8

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.compact ? 28 : 34
                    radius: 18
                    color: Theme.bgLight

                    Text {
                        anchors.centerIn: parent
                        text: "Chi tiết"
                        color: Theme.textSecondary
                        font.pixelSize: root.compact ? 10 : 11
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.detailsClicked()
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.compact ? 28 : 34
                    radius: 18
                    color: root.state === 0 ? Theme.primary :
                           root.state === 1 ? Theme.statusError :
                           root.state === 2 ? Theme.statusDone : Theme.bgLight

                    Text {
                        anchors.centerIn: parent
                        text: root.state === 0 ? "▶  Chọn cổng sạc" :
                              root.state === 1 ? "⏹  Dừng sạc" :
                              root.state === 2 ? "Thanh toán" : "Đặt lại"
                        color: root.state === 0 ? Theme.bgDark : "#ffffff"
                        font.pixelSize: root.compact ? 9 : 11
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.selected()
                    }
                }
            }
        }
    }
}
