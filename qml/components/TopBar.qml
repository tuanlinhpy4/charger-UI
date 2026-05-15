import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    color: "#16213e"

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 16

        // Brand logo: G badge + GEE text
        Row {
            spacing: 10
            Layout.alignment: Qt.AlignVCenter

            // GEE badge
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 32; height: 32
                radius: 8
                color: "#004A99"

                Text {
                    anchors.centerIn: parent
                    text: "G"
                    color: "#ffffff"
                    font.pixelSize: 16
                    font.bold: true
                }
            }

            // GEE logo text
            Column {
                spacing: 0
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: "GEE"
                    color: "#ffffff"
                    font.pixelSize: 15
                    font.bold: true
                    font.letterSpacing: 1
                }
            }
        }

        // EVK info badge
        Rectangle {
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 8
            Layout.preferredWidth: Math.min(210, evkInfoText.implicitWidth + 20)
            height: 26
            radius: 6
            color: Qt.rgba(0, 74 / 255, 153 / 255, 0.3)
            border.color: Qt.rgba(0, 74 / 255, 153 / 255, 0.5)
            border.width: 1

            Text {
                id: evkInfoText
                anchors.centerIn: parent
                width: parent.width - 20
                text: "EV-CHRG-STN-MPU | i.MX 93 | Linux"
                color: "#5BADF5"
                font.pixelSize: 9
                font.weight: Font.DemiBold
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Navigation: Trang chủ | Lịch sử | Cài đặt
        Row {
            spacing: 2
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 8

            Repeater {
                model: ListModel {
                    ListElement { label: "Trang chủ"; screen: "home" }
                    ListElement { label: "Lịch sử"; screen: "history" }
                    ListElement { label: "Cài đặt"; screen: "settings" }
                }

                Rectangle {
                    width: navLabel.width + 32; height: 32
                    radius: 8
                    color: navMouse.containsMouse ? Theme.bgLight : "transparent"

                    property bool isActive: currentScreen === model.screen

                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: 2
                        radius: 1
                        color: Theme.primary
                        visible: parent.isActive
                    }

                    Text {
                        id: navLabel
                        anchors.centerIn: parent
                        text: model.label
                        color: parent.isActive ? Theme.textPrimary : Theme.textSecondary
                        font.pixelSize: 12
                        font.weight: parent.isActive ? Font.DemiBold : Font.Normal
                    }

                    MouseArea {
                        id: navMouse
                        anchors.fill: parent
                        onClicked: root.navClicked(model.screen)
                        hoverEnabled: true
                    }
                }
            }
        }

        Item { Layout.fillWidth: true }

        // 4 connection indicators
        Row {
            spacing: 6
            Layout.alignment: Qt.AlignVCenter

            Repeater {
                model: [
                    { color: Theme.statusReady, tip: "Wi-Fi 6" },
                    { color: Theme.statusReady, tip: "NFC" },
                    { color: Theme.statusReady, tip: "Metrology" },
                    { color: Theme.statusReady, tip: "SE050" }
                ]
                Rectangle {
                    width: 7; height: 7
                    radius: 4
                    color: modelData.color
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // OCPP status
        Row {
            spacing: 6
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
                width: ocppLabel.width + 24; height: 28
                radius: 10
                color: backend.ocppConnected ? "#0D2818" : "#2d1515"

                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    width: 7; height: 7
                    radius: 4
                    color: backend.ocppConnected ? Theme.primary : Theme.statusError

                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    running: Theme.animationsEnabled && backend.ocppConnected
                    NumberAnimation { to: 0.3; duration: 1000; easing.type: Easing.InOutSine }
                    NumberAnimation { to: 1.0; duration: 1000; easing.type: Easing.InOutSine }
                }
                }

                Text {
                    id: ocppLabel
                    anchors.centerIn: parent
                    anchors.leftMargin: 8
                    text: "OCPP 1.6J"
                    color: backend.ocppConnected ? Theme.primary : Theme.statusError
                    font.pixelSize: 10
                    font.weight: Font.Bold
                    anchors.horizontalCenterOffset: anchors.leftMargin / 2 + 10
                }
            }
        }

        // Language selector
        Rectangle {
            width: 36; height: 28
            radius: 10
            color: Theme.bgLight
            Layout.alignment: Qt.AlignVCenter

            Text {
                anchors.centerIn: parent
                text: "VI"
                color: Theme.textSecondary
                font.pixelSize: 11
            }
        }

        // Clock
        Column {
            spacing: 0
            Layout.alignment: Qt.AlignVCenter

            Text {
                text: backend.currentTime
                color: Theme.textPrimary
                font.pixelSize: 14
                font.bold: true
                horizontalAlignment: Text.AlignRight
            }
            Text {
                text: backend.currentDate
                color: Theme.textMuted
                font.pixelSize: 10
                horizontalAlignment: Text.AlignRight
            }
        }
    }

    // Bottom border
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: Qt.rgba(1, 1, 1, 0.04)
    }

    property string currentScreen: "home"

    signal navClicked(string screen)
}
