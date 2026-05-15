import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Rectangle {
    id: root
    color: Theme.bgDark

    property string selectedPort: "A"
    property int authMethod: 0

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

                Text {
                    text: "Xác thực"
                    color: Theme.textPrimary
                    font.pixelSize: 17
                    font.bold: true
                    Layout.alignment: Qt.AlignVCenter
                }

                Rectangle {
                    Layout.preferredWidth: authPortText.implicitWidth + 20
                    Layout.preferredHeight: 24
                    Layout.alignment: Qt.AlignVCenter
                    radius: 12
                    color: Theme.bgLight

                    Text {
                        id: authPortText
                        anchors.centerIn: parent
                        text: selectedPort === "A" ? "Đầu sạc A" : "Đầu sạc B"
                        color: Theme.accent
                        font.pixelSize: 10
                        font.bold: true
                    }
                }

                Item { Layout.fillWidth: true }

                Rectangle {
                    Layout.preferredWidth: authStatusRow.implicitWidth + 24
                    Layout.preferredHeight: 24
                    Layout.alignment: Qt.AlignVCenter
                    radius: 12
                    color: "#0D1F3C"

                    Row {
                        id: authStatusRow
                        anchors.centerIn: parent
                        spacing: 5

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 7; height: 7
                            radius: 4
                            color: Theme.statusCharging
                        }

                        Text {
                            text: "CHỜ XÁC THỰC"
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
                anchors.centerIn: parent
                spacing: 28

                // Left: Auth method list
                Column {
                    spacing: 16
                    width: 240

                    Text {
                        text: "Phương thức xác thực"
                        color: Theme.textPrimary
                        font.pixelSize: 14
                        font.bold: true
                    }

                    Repeater {
                        model: [
                            { icon: "📱", label: "Ứng dụng GETECH", sub: "Quét mã QR", method: 0 },
                            { icon: "💳", label: "Thẻ NFC / RFID", sub: "Chạm thẻ PN7160", method: 1 },
                            { icon: "🔢", label: "Mã PIN", sub: "Nhập mã PIN 6 chữ số", method: 2 },
                            { icon: "🚗", label: "Plug & Charge", sub: "ISO 15118 (tự động)", method: 3 }
                        ]

                        Rectangle {
                            width: 240; height: 72
                            radius: 10
                            color: authMethod === modelData.method ? Qt.rgba(0, 1, 136 / 255, 0.1) : Theme.bgCard
                            border.color: authMethod === modelData.method ? Theme.primary : Theme.textMuted
                            border.width: authMethod === modelData.method ? 2 : 1

                            Row {
                                anchors.fill: parent
                                anchors.margins: 14
                                spacing: 10

                                Text {
                                    text: modelData.icon
                                    font.pixelSize: 24
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                Column {
                                    spacing: 2
                                    anchors.verticalCenter: parent.verticalCenter

                                    Text {
                                        text: modelData.label
                                        color: Theme.textPrimary
                                        font.pixelSize: 12
                                        font.bold: true
                                    }

                                    Text {
                                        text: modelData.sub
                                        color: Theme.textMuted
                                        font.pixelSize: 10
                                    }
                                }

                                Item { Layout.fillWidth: true }

                                Rectangle {
                                    width: 16; height: 16
                                    radius: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: authMethod === modelData.method ? Theme.primary : "transparent"
                                    border.color: authMethod === modelData.method ? Theme.primary : Theme.textMuted
                                    border.width: 2

                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 6; height: 6
                                        radius: 3
                                        color: "#ffffff"
                                        visible: authMethod === modelData.method
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: authMethod = modelData.method
                            }
                        }
                    }
                }

                // Right: Auth panel
                Rectangle {
                    width: 480; height: 400
                    radius: 14
                    color: Theme.bgCard
                    border.color: authMethod === 2 ? Theme.statusDone : Theme.textMuted
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 24
                        spacing: 16

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: authMethod === 0 ? "Quét mã QR" :
                                  authMethod === 1 ? "Chạm thẻ NFC/RFID" :
                                  authMethod === 2 ? "Nhập mã PIN" : "Plug & Charge"
                            color: Theme.textPrimary
                            font.pixelSize: 16
                            font.bold: true
                        }

                        Item { Layout.fillHeight: true; Layout.minimumHeight: 8 }

                        // QR Code method
                        Column {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 14
                            visible: authMethod === 0

                            // QR code box
                            Rectangle {
                                width: 160; height: 160
                                radius: 10
                                color: "#ffffff"
                                anchors.horizontalCenter: parent.horizontalCenter

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
                                                    width: 14; height: 14
                                                    color: (index % 2 === 0 && modelData % 2 === 0) ||
                                                           (index % 2 === 1 && modelData % 2 === 1) ? "#0D1117" : "#ffffff"
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Text {
                                text: "Mở ứng dụng GETECH và quét mã"
                                color: Theme.textSecondary
                                font.pixelSize: 12
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        // NFC method
                        Column {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 14
                            visible: authMethod === 1

                            Rectangle {
                                width: 140; height: 140
                                radius: 70
                                color: Theme.bgLight
                                anchors.horizontalCenter: parent.horizontalCenter

                                Column {
                                    anchors.centerIn: parent
                                    spacing: 6
                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: "💳"
                                        font.pixelSize: 40
                                    }
                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: "Chạm thẻ"
                                        color: Theme.accent
                                        font.pixelSize: 14
                                        font.bold: true
                                    }
                                }

                                SequentialAnimation on opacity {
                                    loops: Animation.Infinite
                                    running: Theme.animationsEnabled
                                    NumberAnimation { to: 0.3; duration: 1000 }
                                    NumberAnimation { to: 1.0; duration: 1000 }
                                }
                            }

                            Text {
                                text: "Chạm thẻ NFC/RFID vào máy đọc PN7160"
                                color: Theme.textSecondary
                                font.pixelSize: 12
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        // PIN method
                        Column {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 14
                            visible: authMethod === 2

                            Row {
                                spacing: 10
                                anchors.horizontalCenter: parent.horizontalCenter

                                Repeater {
                                    id: pinDots
                                    model: 6

                                    Rectangle {
                                        width: 40; height: 48
                                        radius: 8
                                        color: Theme.bgLight
                                        border.color: Theme.textMuted
                                        border.width: 2

                                        Text {
                                            anchors.centerIn: parent
                                            text: pinInput.text.length > index ? "●" : ""
                                            color: Theme.textPrimary
                                            font.pixelSize: 18
                                        }
                                    }
                                }
                            }

                            TextInput {
                                id: pinInput
                                visible: false
                                validator: RegularExpressionValidator { regularExpression: /[0-9]{0,6}/ }
                                onAccepted: if (text.length === 6) authSuccess()
                            }

                            Grid {
                                columns: 3
                                columnSpacing: 8
                                rowSpacing: 8
                                anchors.horizontalCenter: parent.horizontalCenter

                                Repeater {
                                    model: [
                                        "1","2","3","4","5","6","7","8","9","C","0","⌫"
                                    ]

                                    Rectangle {
                                        width: 72; height: 44
                                        radius: 10
                                        color: modelData === "C" ? Theme.bgLight :
                                               modelData === "⌫" ? Theme.bgLight : Theme.bgLight
                                        border.color: Theme.textMuted
                                        border.width: 1

                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData
                                            color: modelData === "C" ? Theme.textMuted :
                                                   modelData === "⌫" ? Theme.statusError : Theme.textPrimary
                                            font.pixelSize: 18
                                            font.bold: modelData !== "C" && modelData !== "⌫"
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                if (modelData === "C") {
                                                    pinInput.text = ""
                                                } else if (modelData === "⌫") {
                                                    if (pinInput.text.length > 0)
                                                        pinInput.text = pinInput.text.slice(0, -1)
                                                } else {
                                                    if (pinInput.text.length < 6)
                                                        pinInput.text += modelData
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        // Plug & Charge method
                        Column {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 14
                            visible: authMethod === 3

                            Rectangle {
                                width: 140; height: 140
                                radius: 70
                                color: Theme.bgLight
                                anchors.horizontalCenter: parent.horizontalCenter

                                Column {
                                    anchors.centerIn: parent
                                    spacing: 8

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: "🚗"
                                        font.pixelSize: 40
                                    }
                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: "Đang xác thực..."
                                        color: Theme.primary
                                        font.pixelSize: 14
                                        font.bold: true
                                    }
                                }

                                SequentialAnimation on opacity {
                                    loops: Animation.Infinite
                                    running: Theme.animationsEnabled
                                    NumberAnimation { to: 0.2; duration: 800 }
                                    NumberAnimation { to: 1.0; duration: 800 }
                                }
                            }

                            Text {
                                text: "Cắm cáp sạc vào xe để bắt đầu"
                                color: Theme.textSecondary
                                font.pixelSize: 12
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                text: "ISO 15118-2 / ISO 15118-20"
                                color: Theme.textMuted
                                font.pixelSize: 11
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Item { Layout.fillHeight: true; Layout.minimumHeight: 8 }

                        // Action buttons
                        Row {
                            spacing: 10
                            Layout.alignment: Qt.AlignHCenter

                            Rectangle {
                                width: 140; height: 40
                                radius: 20
                                color: Theme.bgLight

                                Text {
                                    anchors.centerIn: parent
                                    text: "← Quay lại"
                                    color: Theme.textSecondary
                                    font.pixelSize: 12
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: screenSelect("home", selectedPort)
                                }
                            }

                            Rectangle {
                                width: 160; height: 40
                                radius: 20
                                color: Theme.primary

                                Text {
                                    anchors.centerIn: parent
                                    text: "Tiếp tục →"
                                    color: "#0D1117"
                                    font.pixelSize: 12
                                    font.bold: true
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: authSuccess()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function authSuccess() {
        backend.authenticatePort(selectedPort, authMethod, "")
        backend.startChargingOnPort(selectedPort)
        screenSelect("charging", selectedPort)
    }

    signal screenSelect(string screen, string port)
}
