import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: panel

    property var port
    property color panelGradient1: "#0077B6"
    property color panelGradient2: "#00B4D8"
    property int panelWidth: 460
    property int panelHeight: 500

    width: panelWidth
    height: panelHeight
    radius: 16
    color: "#0f3460"

    // Gradient overlay
    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        opacity: 0.15
        gradient: Gradient {
            GradientStop { position: 0.0; color: panelGradient1 }
            GradientStop { position: 1.0; color: panelGradient2 }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        // ── Header: Port name + Connector + Power ──
        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            // Connector icon
            Rectangle {
                width: 10; height: 10; radius: 5
                color: stateColor(port.state)
            }

            Text {
                text: port.name
                color: "#ffffff"
                font.pixelSize: 18
                font.bold: true
            }

            Item { Layout.fillWidth: true }

            // Connector badge
            Rectangle {
                width: connLabel.width + 16; height: 26
                radius: 13
                color: Qt.rgba(1, 1, 1, 0.13)
                Text {
                    id: connLabel
                    anchors.centerIn: parent
                    text: port.connector
                    color: "#ffffff"
                    font.pixelSize: 12
                    font.bold: true
                }
            }

            Text {
                text: port.maxPower + " kW"
                color: "#aaddff"
                font.pixelSize: 16
                font.bold: true
            }
        }

        // ── Status badge ──
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: statusText.width + 24; height: 28
            radius: 14
            color: stateColor(port.state)
            Text {
                id: statusText
                anchors.centerIn: parent
                text: stateText(port.state)
                color: "#ffffff"
                font.pixelSize: 12
                font.bold: true
            }
        }

        // ── Center content: changes based on state ──
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // ── CHARGING VIEW ──
            Column {
                anchors.centerIn: parent
                spacing: 14
                visible: port.state === 1 || port.state === 2

                // Battery visual
                Item {
                    width: 120; height: 160
                    anchors.horizontalCenter: parent.horizontalCenter

                    // Battery outline
                    Rectangle {
                        id: batteryOutline
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 80; height: 140
                        radius: 8
                        color: "transparent"
                        border.color: Qt.rgba(1, 1, 1, 0.33)
                        border.width: 2

                        // Battery fill
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 4
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width - 8
                            height: Math.max(4, (parent.height - 8) * port.batteryPercent / 100.0)
                            radius: 4
                            color: port.batteryPercent > 80 ? "#4CAF50" :
                                   port.batteryPercent > 40 ? "#2196F3" : "#FF9800"

                            Behavior on height {
                                NumberAnimation { duration: 800; easing.type: Easing.OutCubic }
                            }
                        }
                    }

                    // Battery cap
                    Rectangle {
                        anchors.bottom: batteryOutline.top
                        anchors.bottomMargin: -1
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 30; height: 8
                        radius: 3
                        color: Qt.rgba(1, 1, 1, 0.33)
                    }

                    // Percentage text on battery
                    Text {
                        anchors.centerIn: batteryOutline
                        text: Math.floor(port.batteryPercent) + "%"
                        color: "#ffffff"
                        font.pixelSize: 22
                        font.bold: true

                        // Glow effect
                        layer.enabled: true
                    }

                    // Charging bolt animation
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: batteryOutline.top
                        anchors.topMargin: 8
                        text: "⚡"
                        font.pixelSize: 20
                        visible: port.state === 1
                        opacity: boltAnim.running ? 1.0 : 0.3

                        SequentialAnimation on opacity {
                            id: boltAnim
                            running: port.state === 1
                            loops: Animation.Infinite
                            NumberAnimation { to: 0.3; duration: 600 }
                            NumberAnimation { to: 1.0; duration: 600 }
                        }
                    }
                }

                // Stats grid
                Grid {
                    columns: 2
                    columnSpacing: 20
                    rowSpacing: 8
                    anchors.horizontalCenter: parent.horizontalCenter

                    // Energy
                    Text { text: "Năng lượng:"; color: "#aaa"; font.pixelSize: 13 }
                    Text {
                        text: port.energyDelivered.toFixed(2) + " kW·h"
                        color: "#ffffff"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    // Power
                    Text { text: "Công suất:"; color: "#aaa"; font.pixelSize: 13 }
                    Text {
                        text: port.currentPower.toFixed(1) + " kW"
                        color: "#ffffff"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    // Time
                    Text { text: "Thời gian:"; color: "#aaa"; font.pixelSize: 13 }
                    Text {
                        text: formatTime(port.elapsedSeconds)
                        color: "#ffffff"
                        font.pixelSize: 14
                        font.bold: true
                    }
                }
            }

            // ── AVAILABLE VIEW ──
            Column {
                anchors.centerIn: parent
                spacing: 20
                visible: port.state === 0

                // Car + plug illustration (text-based)
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "🔌  🚗"
                    font.pixelSize: 52
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Cắm sạc để bắt đầu"
                    color: "#aaaaaa"
                    font.pixelSize: 15
                }
            }
        }

        // ── Bottom action bar ──
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            // Chi tiết / Details button
            Rectangle {
                Layout.preferredWidth: 120; Layout.preferredHeight: 40
                radius: 20
                color: Qt.rgba(1, 1, 1, 0.08)
                border.color: Qt.rgba(1, 1, 1, 0.2)
                border.width: 1

                Row {
                    anchors.centerIn: parent
                    spacing: 6
                    Text {
                        text: "Chi tiết"
                        color: "#cccccc"
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "ⓘ"
                        color: "#cccccc"
                        font.pixelSize: 14
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log(port.name + ": show details")
                    }
                }
            }

            Item { Layout.fillWidth: true }

            // Start / Stop button
            Rectangle {
                Layout.preferredWidth: 140; Layout.preferredHeight: 44
                radius: 22
                color: port.state === 0 ? "#4CAF50" :
                       port.state === 1 ? "#F44336" : "#FF9800"

                // Subtle glow
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -2
                    radius: parent.radius + 2
                    color: parent.color
                    opacity: 0.3
                    z: -1
                }

                Text {
                    anchors.centerIn: parent
                    text: port.state === 0 ? "Bắt đầu ▶" :
                          port.state === 1 ? "Dừng ■" : "Đặt lại ↻"
                    color: "#ffffff"
                    font.pixelSize: 14
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (port.state === 0)
                            port.startCharging()
                        else
                            port.stopCharging()
                    }
                }

                // Press animation
                scale: actionMa.pressed ? 0.95 : 1.0
                Behavior on scale {
                    NumberAnimation { duration: 100 }
                }
                MouseArea {
                    id: actionMa
                    anchors.fill: parent
                    onClicked: {
                        if (port.state === 0)
                            port.startCharging()
                        else
                            port.stopCharging()
                    }
                }
            }
        }
    }
}
