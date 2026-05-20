import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Rectangle {
    id: root
    color: Theme.bgDark

    property string selectedPort: "A"
    property var currentPort: selectedPort === "A" ? backend.portA : backend.portB
    property int paymentMethod: 0

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
                        onClicked: screenSelect("session_details", selectedPort)
                    }
                }

                Column {
                    spacing: 2
                    Layout.alignment: Qt.AlignVCenter

                    Text {
                        text: "Thanh toán"
                        color: Theme.textPrimary
                        font.pixelSize: 15
                        font.bold: true
                    }

                    Text {
                        text: "Phiên #EV802341 • " + currentPort.name
                        color: Theme.textMuted
                        font.pixelSize: 10
                    }
                }

                Item { Layout.fillWidth: true }

                Rectangle {
                    Layout.preferredWidth: paymentStatusRow.implicitWidth + 24
                    Layout.preferredHeight: 24
                    Layout.alignment: Qt.AlignVCenter
                    radius: 12
                    color: "#2D1F08"

                    Row {
                        id: paymentStatusRow
                        anchors.centerIn: parent
                        spacing: 5

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 7; height: 7; radius: 4
                            color: Theme.statusDone
                        }

                        Text {
                            text: "HOÀN THÀNH"
                            color: Theme.statusDone
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
                spacing: 28

                // Left: Summary
                Column {
                    spacing: 16
                    width: 360

                    // Total amount
                    Rectangle {
                        width: 360
                        height: 140
                        radius: 14
                        color: Theme.bgCard
                        border.color: Theme.statusDone
                        border.width: 2

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 6

                            Text {
                                text: "Số tiền thanh toán"
                                color: Theme.textSecondary
                                font.pixelSize: 12
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                text: (currentPort.energyDelivered * 3500 + 30000).toLocaleString('vi-VN')
                                color: Theme.statusDone
                                font.pixelSize: 40
                                font.bold: true
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                text: "đ"
                                color: Theme.statusDone
                                font.pixelSize: 16
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    // Invoice details
                    Rectangle {
                        width: 360
                        height: 252
                        radius: 12
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 8

                            Text {
                                text: "Chi tiết hóa đơn"
                                color: Theme.textPrimary
                                font.pixelSize: 13
                                font.bold: true
                            }

                            Repeater {
                                model: ["Đầu sạc", "Điện năng", "Đơn giá", "Phí dịch vụ"]

                                Rectangle {
                                    radius: 6
                                    color: Theme.bgLight
                                    Layout.preferredHeight: 36
                                    Layout.fillWidth: true

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 10

                                        Text { text: modelData; color: Theme.textMuted; font.pixelSize: 11; Layout.alignment: Qt.AlignVCenter }
                                        Item { Layout.fillWidth: true }
                                        Text {
                                            text: index === 0 ? currentPort.name :
                                                  index === 1 ? currentPort.energyDelivered.toFixed(3) + " kWh" :
                                                  index === 2 ? "3.500 đ/kWh" :
                                                  "30.000 đ"
                                            color: Theme.textPrimary
                                            font.pixelSize: 11
                                            font.bold: true
                                            Layout.alignment: Qt.AlignVCenter
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 1
                                color: Theme.textMuted
                                opacity: 0.3
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 22

                                Text { text: "Tổng cộng"; color: Theme.textPrimary; font.pixelSize: 12; font.bold: true }
                                Item { Layout.fillWidth: true }
                                Text {
                                    text: (currentPort.energyDelivered * 3500 + 30000).toLocaleString('vi-VN') + " đ"
                                    color: Theme.statusDone; font.pixelSize: 14; font.bold: true
                                }
                            }
                        }
                    }

                    // Session summary
                    Rectangle {
                        width: 360
                        height: 80
                        radius: 12
                        color: Theme.bgCard
                        border.color: Theme.textMuted
                        border.width: 1

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 14

                            Repeater {
                                model: ["SOC", "Công suất TB", "Giờ"]

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    color: "transparent"
                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 4
                                        Text { text: modelData; color: Theme.textMuted; font.pixelSize: 11 }
                                        Text {
                                            text: index === 0 ? Math.floor(currentPort.batteryPercent) + "%" :
                                                  index === 1 ? (currentPort.elapsedSeconds > 0 ? (currentPort.energyDelivered / (currentPort.elapsedSeconds / 3600)).toFixed(1) + " kW" : "—") :
                                                  "Bình thường"
                                            color: Theme.accent
                                            font.pixelSize: 14
                                            font.bold: true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Right: Payment methods
                Column {
                    spacing: 12
                    width: 480

                    Text {
                        text: "Phương thức thanh toán"
                        color: Theme.textPrimary
                        font.pixelSize: 14
                        font.bold: true
                    }

                    Repeater {
                        model: [
                            { icon: "💳", label: "Thẻ tín dụng / Ghi nợ", sub: "Visa, Mastercard, JCB", method: 0 },
                            { icon: "📱", label: "Ví điện tử", sub: "VNPay, MoMo, ZaloPay", method: 1 },
                            { icon: "🏦", label: "Chuyển khoản ngân hàng", sub: "QR Code ngân hàng", method: 2 },
                            { icon: "💰", label: "Tài khoản GETECH", sub: "Số dư: 500.000 đ", method: 3 },
                            { icon: "📄", label: "Thanh toán sau (Doanh nghiệp)", sub: "Hóa đơn cuối tháng", method: 4 }
                        ]

                        Rectangle {
                            width: 480; height: 56
                            radius: 10
                            color: paymentMethod === modelData.method ? Qt.rgba(0, 1, 136 / 255, 0.07) : Theme.bgCard
                            border.color: paymentMethod === modelData.method ? Theme.primary : Theme.textMuted
                            border.width: paymentMethod === modelData.method ? 2 : 1

                            Row {
                                anchors.fill: parent
                                anchors.margins: 14
                                spacing: 12

                                Text {
                                    text: modelData.icon
                                    font.pixelSize: 22
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
                                    width: 18; height: 18
                                    radius: 9
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: paymentMethod === modelData.method ? Theme.primary : "transparent"
                                    border.color: paymentMethod === modelData.method ? Theme.primary : Theme.textMuted
                                    border.width: 2

                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 6; height: 6
                                        radius: 3
                                        color: "#ffffff"
                                        visible: paymentMethod === modelData.method
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: paymentMethod = modelData.method
                            }
                        }
                    }

                    Item { Layout.fillHeight: true }

                    // Pay button
                    Row {
                        spacing: 12
                        Layout.alignment: Qt.AlignHCenter

                        Rectangle {
                            width: 160; height: 40
                            radius: 20
                            color: Theme.bgLight

                            Text {
                                anchors.centerIn: parent
                                text: "Hủy"
                                color: Theme.textSecondary
                                font.pixelSize: 12
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: cancelConfirm.visible = true
                            }
                        }

                        Rectangle {
                            width: 220; height: 40
                            radius: 20
                            color: Theme.statusDone

                            Row {
                                anchors.centerIn: parent
                                spacing: 8

                                Text { text: "💳"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
                                Text {
                                    text: "Thanh toán " + (currentPort.energyDelivered * 3500 + 30000).toLocaleString('vi-VN') + " đ"
                                    color: "#ffffff"
                                    font.pixelSize: 12
                                    font.bold: true
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: doPayment()
                            }
                        }
                    }

                    // Security badges
                    Row {
                        spacing: 14
                        Layout.alignment: Qt.AlignHCenter

                        Repeater {
                            model: [
                                { icon: "🔒", text: "Mã hóa SSL" },
                                { icon: "✓", text: "PCI-DSS" },
                                { icon: "🛡️", text: "Bảo hiểm" },
                                { icon: "📧", text: "Hóa đơn email" }
                            ]

                            Row { spacing: 4
                                Text { text: modelData.icon; font.pixelSize: 10 }
                                Text { text: modelData.text; color: Theme.textMuted; font.pixelSize: 9 }
                            }
                        }
                    }
                }
            }
        }
    }

    function doPayment() {
        backend.stopCharging(selectedPort)
        paymentDialog.visible = true
    }

    function completePayment() {
        paymentDialog.visible = false
        currentPort.resetPort()
        screenSelect("home", selectedPort)
    }

    // Payment success dialog
    Rectangle {
        id: paymentDialog
        visible: false
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.5)

        Rectangle {
            anchors.centerIn: parent
            width: 420; height: 300
            radius: 16
            color: Theme.bgCard

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 32
                spacing: 16

                Item { Layout.fillHeight: true }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "✓"
                    font.pixelSize: 64
                    color: Theme.primary
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Thanh toán thành công!"
                    color: Theme.textPrimary
                    font.pixelSize: 22
                    font.bold: true
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Mã giao dịch: #TXN" + String(Math.floor(Math.random() * 900000 + 100000))
                    color: Theme.textSecondary
                    font.pixelSize: 13
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Hóa đơn đã được gửi qua email"
                    color: Theme.textMuted
                    font.pixelSize: 12
                }

                Item { Layout.fillHeight: true }

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    width: 200; height: 44
                    radius: 22
                    color: Theme.primary

                    Text {
                        anchors.centerIn: parent
                        text: "Hoàn tất ✓"
                        color: "#0D1117"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: completePayment()
                    }
                }
            }
        }
    }

    // Cancel confirmation dialog
    Rectangle {
        id: cancelConfirm
        visible: false
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.5)

        Rectangle {
            anchors.centerIn: parent
            width: 400; height: 240
            radius: 16
            color: Theme.bgCard

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 32
                spacing: 16

                Item { Layout.fillHeight: true }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "⚠"
                    font.pixelSize: 48
                    color: Theme.statusError
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Hủy thanh toán?"
                    color: Theme.textPrimary
                    font.pixelSize: 20
                    font.bold: true
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Bạn có thể thanh toán sau từ mục Lịch sử"
                    color: Theme.textSecondary
                    font.pixelSize: 13
                }

                Item { Layout.fillHeight: true }

                Row {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 12

                    Rectangle {
                        width: 140; height: 40
                        radius: 20
                        color: Theme.bgLight

                        Text {
                            anchors.centerIn: parent
                            text: "Tiếp tục thanh toán"
                            color: Theme.textSecondary
                            font.pixelSize: 12
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: cancelConfirm.visible = false
                        }
                    }

                    Rectangle {
                        width: 140; height: 40
                        radius: 20
                        color: Theme.statusError

                        Text {
                            anchors.centerIn: parent
                            text: "Hủy"
                            color: "#ffffff"
                            font.pixelSize: 12
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: { cancelConfirm.visible = false; screenSelect("home", selectedPort) }
                        }
                    }
                }
            }
        }
    }

    signal screenSelect(string screen, string port)
}
