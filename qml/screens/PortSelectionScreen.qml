import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Rectangle {
    id: root
    color: Theme.bgDark

    property string selectedPort: "A"

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

                Text {
                    text: "Chọn cổng sạc"
                    color: Theme.textPrimary
                    font.pixelSize: 17
                    font.bold: true
                    Layout.alignment: Qt.AlignVCenter
                }

                Rectangle {
                    Layout.preferredWidth: selectedPortText.implicitWidth + 24
                    Layout.preferredHeight: 24
                    Layout.alignment: Qt.AlignVCenter
                    radius: 12
                    color: "#2D1F08"

                    Text {
                        id: selectedPortText
                        anchors.centerIn: parent
                        text: selectedPort === "A" ? "Đầu sạc A" : "Đầu sạc B"
                        color: Theme.statusDone
                        font.pixelSize: 10
                        font.bold: true
                    }
                }

                Item { Layout.fillWidth: true }

                Rectangle {
                    Layout.preferredWidth: readyStatusRow.implicitWidth + 24
                    Layout.preferredHeight: 24
                    Layout.alignment: Qt.AlignVCenter
                    radius: 12
                    color: "#0D2818"

                    Row {
                        id: readyStatusRow
                        anchors.centerIn: parent
                        spacing: 5

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 7; height: 7; radius: 4
                            color: Theme.primary
                        }

                        Text {
                            text: "SẴN SÀNG"
                            color: Theme.primary
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
                anchors.centerIn: parent
                spacing: 20

                // Port A
                Column {
                    spacing: 16
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        width: 360
                        height: 328
                        radius: 16
                        color: Theme.bgCard
                        border.color: selectedPort === "A" ? Theme.primary : "transparent"
                        border.width: 2

                        Behavior on border.color {
                            enabled: Theme.animationsEnabled
                            ColorAnimation { duration: Theme.animationsEnabled ? 120 : 0 }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: selectedPort = "A"
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 12

                            // Header
                            RowLayout {
                                Layout.fillWidth: true

                                Rectangle {
                                    width: 12; height: 12; radius: 6
                                    color: Theme.statusCharging
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                Text {
                                    text: "Đầu sạc A"
                                    color: Theme.textPrimary
                                    font.pixelSize: 18
                                    font.bold: true
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                Item { Layout.fillWidth: true }

                                Rectangle {
                                    Layout.preferredWidth: aStatusText.implicitWidth + 24
                                    Layout.preferredHeight: 24
                                    radius: 10
                                    color: "#238636"
                                    Layout.alignment: Qt.AlignVCenter

                                    Text {
                                        id: aStatusText
                                        anchors.centerIn: parent
                                        text: "SẴN SÀNG"
                                        color: "#ffffff"
                                        font.pixelSize: 10
                                        font.bold: true
                                    }
                                }
                            }

                            // Connector tabs
                            Row {
                                spacing: 8
                                Layout.alignment: Qt.AlignHCenter

                                Rectangle {
                                    radius: 8
                                    color: Theme.statusCharging
                                    width: 70
                                    height: 28
                                    Text {
                                        anchors.centerIn: parent
                                        text: "CCS2"
                                        color: "#ffffff"
                                        font.pixelSize: 12
                                        font.bold: true
                                    }
                                }

                                Rectangle {
                                    radius: 8
                                    color: Theme.bgLight
                                    width: 90
                                    height: 28
                                    Text {
                                        anchors.centerIn: parent
                                        text: "CHAdeMO"
                                        color: Theme.textMuted
                                        font.pixelSize: 12
                                    }
                                }

                                Rectangle {
                                    radius: 8
                                    color: Theme.bgLight
                                    width: 70
                                    height: 28
                                    Text {
                                        anchors.centerIn: parent
                                        text: "Type 2"
                                        color: Theme.textMuted
                                        font.pixelSize: 12
                                    }
                                }
                            }

                            // Specs grid
                            Grid {
                                columns: 2
                                columnSpacing: 8
                                rowSpacing: 8
                                Layout.fillWidth: true

                                Rectangle {
                                    width: 156
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 48
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Công suất tối đa"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: "120 kW"; color: Theme.accent; font.pixelSize: 12; font.bold: true }
                                    }
                                }

                                Rectangle {
                                    width: 156
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 48
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Điện áp"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: "200–1000V DC"; color: Theme.textPrimary; font.pixelSize: 12; font.bold: true }
                                    }
                                }

                                Rectangle {
                                    width: 156
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 48
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Dòng điện"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: "Up to 300A"; color: Theme.textPrimary; font.pixelSize: 12; font.bold: true }
                                    }
                                }

                                Rectangle {
                                    width: 156
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 48
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Giao thức"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: "ISO 15118-2"; color: Theme.primary; font.pixelSize: 12; font.bold: true }
                                    }
                                }
                            }

                            // Select button
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                radius: 24
                                color: selectedPort === "A" ? Theme.primary : Theme.bgLight

                                Text {
                                    anchors.centerIn: parent
                                    text: selectedPort === "A" ? "✓ Đã chọn" : "Chọn cổng này"
                                    color: selectedPort === "A" ? "#0D1117" : Theme.textMuted
                                    font.pixelSize: 14
                                    font.bold: true
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        selectedPort = "A"
                                        screenSelect("auth", "A")
                                    }
                                }
                            }
                        }
                    }
                }

                // Port B
                Column {
                    spacing: 16
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        width: 360
                        height: 328
                        radius: 16
                        color: Theme.bgCard
                        border.color: selectedPort === "B" ? Theme.primary : "transparent"
                        border.width: 2

                        Behavior on border.color {
                            enabled: Theme.animationsEnabled
                            ColorAnimation { duration: Theme.animationsEnabled ? 120 : 0 }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: selectedPort = "B"
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true

                                Rectangle {
                                    width: 12; height: 12; radius: 6
                                    color: Theme.statusReady
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                Text {
                                    text: "Đầu sạc B"
                                    color: Theme.textPrimary
                                    font.pixelSize: 18
                                    font.bold: true
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                Item { Layout.fillWidth: true }

                                Rectangle {
                                    Layout.preferredWidth: bStatusText.implicitWidth + 24
                                    Layout.preferredHeight: 24
                                    radius: 10
                                    color: "#238636"
                                    Layout.alignment: Qt.AlignVCenter

                                    Text {
                                        id: bStatusText
                                        anchors.centerIn: parent
                                        text: "SẴN SÀNG"
                                        color: "#ffffff"
                                        font.pixelSize: 10
                                        font.bold: true
                                    }
                                }
                            }

                            Row {
                                spacing: 8
                                Layout.alignment: Qt.AlignHCenter

                                Rectangle {
                                    radius: 8
                                    color: Theme.statusCharging
                                    width: 70
                                    height: 28
                                    Text {
                                        anchors.centerIn: parent
                                        text: "CCS2"
                                        color: "#ffffff"
                                        font.pixelSize: 12
                                        font.bold: true
                                    }
                                }

                                Rectangle {
                                    radius: 8
                                    color: Theme.bgLight
                                    width: 90
                                    height: 28
                                    Text {
                                        anchors.centerIn: parent
                                        text: "CHAdeMO"
                                        color: Theme.textMuted
                                        font.pixelSize: 12
                                    }
                                }

                                Rectangle {
                                    radius: 8
                                    color: Theme.bgLight
                                    width: 70
                                    height: 28
                                    Text {
                                        anchors.centerIn: parent
                                        text: "Type 2"
                                        color: Theme.textMuted
                                        font.pixelSize: 12
                                    }
                                }
                            }

                            Grid {
                                columns: 2
                                columnSpacing: 8
                                rowSpacing: 8
                                Layout.fillWidth: true

                                Rectangle {
                                    width: 156
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 48
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Công suất tối đa"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: "120 kW"; color: Theme.accent; font.pixelSize: 12; font.bold: true }
                                    }
                                }

                                Rectangle {
                                    width: 156
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 48
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Điện áp"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: "200–1000V DC"; color: Theme.textPrimary; font.pixelSize: 12; font.bold: true }
                                    }
                                }

                                Rectangle {
                                    width: 156
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 48
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Dòng điện"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: "Up to 300A"; color: Theme.textPrimary; font.pixelSize: 12; font.bold: true }
                                    }
                                }

                                Rectangle {
                                    width: 156
                                    radius: 8
                                    color: Theme.bgLight
                                    height: 48
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 2
                                        Text { text: "Giao thức"; color: Theme.textMuted; font.pixelSize: 9 }
                                        Text { text: "ISO 15118-2"; color: Theme.primary; font.pixelSize: 12; font.bold: true }
                                    }
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                radius: 24
                                color: selectedPort === "B" ? Theme.primary : Theme.bgLight

                                Text {
                                    anchors.centerIn: parent
                                    text: selectedPort === "B" ? "✓ Đã chọn" : "Chọn cổng này"
                                    color: selectedPort === "B" ? "#0D1117" : Theme.textMuted
                                    font.pixelSize: 14
                                    font.bold: true
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        selectedPort = "B"
                                        screenSelect("auth", "B")
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
