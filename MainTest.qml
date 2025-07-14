import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "black"

    // Background image
    Image {
        anchors.fill: parent
        source: "background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000B3" // black with 70% opacity
    }

    // Time
    property string currentTime: Qt.formatTime(new Date(), "hh:mm:ss")
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.currentTime = Qt.formatTime(new Date(), "hh:mm:ss")
    }

    // States
    property bool showScanner: false
    property bool scanComplete: false
    property int loginAttempts: 0
    property string securityLevel: "HIGH"

    // --- System Info (Top Left) ---
    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        spacing: 6
        Text { text: "SECURITY LEVEL: " + securityLevel; color: "#ff6b52"; font.family: "monospace"; font.pixelSize: 14 }
        Text { text: "SYSTEM: ARCH LINUX"; color: "#ff6b52"; font.family: "monospace"; font.pixelSize: 14 }
        Text { text: "KERNEL: 6.5.3"; color: "#ff6b52"; font.family: "monospace"; font.pixelSize: 14 }
        Text { text: "NETWORK: SECURE"; color: "#ff6b52"; font.family: "monospace"; font.pixelSize: 14 }
    }

    // --- System Stats (Top Right) ---
    Column {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        spacing: 6
        Text { text: "LOGIN ATTEMPTS: " + loginAttempts; color: "#ff6b52"; font.family: "monospace"; font.pixelSize: 14 }
        Text { text: "SYSTEM UPTIME: 23:45:12"; color: "#ff6b52"; font.family: "monospace"; font.pixelSize: 14 }
        Text { text: "TIME: " + root.currentTime; color: "#ff6b52"; font.family: "monospace"; font.pixelSize: 14 }
    }

    // --- Login UI ---
    Column {
        anchors.centerIn: parent
        spacing: 12
        width: 300

        // Avatar
        Rectangle {
            width: 80
            height: 80
            radius: 40
            color: "#1e1e1e"
            border.color: "#ff6b52"
            border.width: 2
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                anchors.centerIn: parent
                source: "user_icon.svg" // Replace with your SVG icon
                width: 48
                height: 48
                fillMode: Image.PreserveAspectFit
            }
        }

        Text {
            text: "Girquell"
            color: "white"
            font.pixelSize: 22
            font.family: "monospace"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "Arch Linux"
            color: "#cccccc"
            font.pixelSize: 14
            font.family: "monospace"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Password input
        TextField {
            id: passwordInput
            echoMode: TextInput.Password
            placeholderText: "Password"
            font.family: "monospace"
            font.pixelSize: 14
            width: parent.width
            color: "white"
            background: Rectangle {
                color: "#1e1e1e"
                border.color: "#ff6b52"
                border.width: 1
            }
        }

        // Buttons
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: "BACK"
                background: Rectangle {
                    color: "#ff6b521A"
                    radius: 3
                }
                onClicked: Qt.quit()
            }

            Button {
                text: "LOGIN"
                background: Rectangle {
                    color: "#ff6b52"
                    radius: 3
                }
                onClicked: {
                    showScanner = true
                    scanComplete = false
                    scanTimer.start()
                }
            }
        }
    }

    // --- Scanner Overlay ---
    Rectangle {
        anchors.fill: parent
        visible: showScanner
        color: "#000000AA"
        z: 10

        Text {
            anchors.centerIn: parent
            text: scanComplete ? "SCAN COMPLETE" : "SCANNING..."
            color: "#ff6b52"
            font.pixelSize: 24
            font.family: "monospace"
        }
    }

    // Scanner simulation logic
    Timer {
        id: scanTimer
        interval: 2000
        repeat: false
        onTriggered: {
            scanComplete = true
            cleanupTimer.start()
        }
    }

    Timer {
        id: cleanupTimer
        interval: 1000
        repeat: false
        onTriggered: {
            showScanner = false
            scanComplete = false
            loginAttempts += 1
        }
    }

    // --- Shutdown Button ---
    MouseArea {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        width: 150
        height: 40
        onClicked: sddm.powerOff()

        Text {
            anchors.centerIn: parent
            text: "⏻  Shutdown"
            color: "#ff6b52"
            font.family: "monospace"
            font.pixelSize: 16
        }
    }
}
