import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    property string message: "Thông báo"
    property string subtext: ""
    property string buttonText: "Đóng"
    property int iconType: 0
    property bool showCancel: false
    property int resultCode: 0

    signal confirmed()
    signal cancelled()

    color: Qt.rgba(0, 0, 0, 0.5)
    radius: Theme.radiusL

    Rectangle {
        anchors.centerIn: parent
        width: 400
        height: Math.max(220, contentCol.height + 80)
        radius: Theme.radiusL
        color: Theme.bgCard

        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: parent.radius
            color: "transparent"
            border.color: iconType === 3 ? Theme.statusError :
                          iconType === 1 ? Theme.statusDone :
                          iconType === 2 ? Theme.statusCharging : Theme.primary
            border.width: 2
        }

        ColumnLayout {
            id: contentCol
            anchors.fill: parent
            anchors.margins: 28
            spacing: 16

            Item { Layout.fillHeight: true }

            // Icon
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: iconType === 0 ? "ℹ" :
                      iconType === 1 ? "✓" :
                      iconType === 2 ? "⚡" : "⚠"
                font.pixelSize: 44
                color: iconType === 3 ? Theme.statusError :
                       iconType === 1 ? Theme.statusReady :
                       iconType === 2 ? Theme.statusCharging : Theme.textSecondary
            }

            // Message
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: message
                color: Theme.textPrimary
                font.pixelSize: 18
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            // Subtext
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: subtext
                color: Theme.textSecondary
                font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                visible: subtext !== ""
            }

            Item { Layout.fillHeight: true }

            // Buttons
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 12

                Rectangle {
                    width: cancelBtn.width; height: 44
                    radius: 22
                    color: Theme.bgLight
                    visible: showCancel

                    Text {
                        id: cancelBtn
                        anchors.centerIn: parent
                        anchors.margins: 24
                        text: "Hủy"
                        color: Theme.textSecondary
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.cancelled()
                    }
                }

                Rectangle {
                    width: confirmBtn.width; height: 44
                    radius: 22
                    color: iconType === 3 ? Theme.statusError : Theme.primary

                    Text {
                        id: confirmBtn
                        anchors.centerIn: parent
                        anchors.margins: 28
                        text: buttonText
                        color: "#ffffff"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.confirmed()
                    }
                }
            }
        }
    }
}
