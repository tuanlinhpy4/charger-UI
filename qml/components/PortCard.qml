import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

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
            anchors.margins: 16
            spacing: 8

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
                    font.pixelSize: 16
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
                    font.pixelSize: 12
                    font.bold: true
                    Layout.alignment: Qt.AlignVCenter
                }
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: statusText.implicitWidth + 28
                height: 24
                radius: 12
                color: root.stateColor(root.state)

                Text {
                    id: statusText
                    anchors.centerIn: parent
                    text: root.stateText(root.state)
                    color: "#ffffff"
                    font.pixelSize: 10
                    font.bold: true
                }
            }

            Item {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 72
                Layout.preferredHeight: 96

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 50
                    height: 78
                    radius: 5
                    color: "transparent"
                    border.color: Theme.textMuted
                    border.width: 2
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 42
                    height: root.state === 0 ? 0 : Math.max(4, 72 * root.batteryPercent / 100.0)
                    radius: 3
                    color: root.state === 1 ? Theme.statusCharging : root.stateColor(root.state)
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 81
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 20
                    height: 5
                    radius: 2
                    color: Theme.textMuted
                }

                Text {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 8
                    text: root.displayBattery()
                    color: "#ffffff"
                    font.pixelSize: 15
                    font.bold: true
                }

                Text {
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
                Layout.preferredHeight: 56
                columns: 2
                columnSpacing: 16
                rowSpacing: 4

                Repeater {
                    model: [
                        { label: "Năng lượng", value: root.energyDelivered.toFixed(2) + " kWh" },
                        { label: "Công suất", value: root.currentPower.toFixed(1) + " kW" },
                        { label: "Thời gian", value: root.displayTime() },
                        { label: "Giá", value: root.displayCost() }
                    ]

                    Column {
                        width: (parent.width - parent.columnSpacing) / 2
                        height: 24
                        spacing: 1

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

            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 34
                spacing: 8

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 34
                    radius: 18
                    color: Theme.bgLight

                    Text {
                        anchors.centerIn: parent
                        text: "Chi tiết"
                        color: Theme.textSecondary
                        font.pixelSize: 11
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.detailsClicked()
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 34
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
                        font.pixelSize: 11
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
