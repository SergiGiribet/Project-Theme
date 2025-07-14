// Main.qml
import QtQuick 2.0
import SddmComponents 2.0
import QtGraphicalEffects 1.0
import "components"

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#000000"

    FontLoader {
        id: monospaceFont
        source: "fonts/YourMonospaceFont.ttf"
    }

    Image {
        id: bg
        source: "images/background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        id: overlay
        anchors.fill: parent
        color: "#000000AA"
    }

    Rectangle {
        id: scanlineOverlay
        anchors.fill: parent
        opacity: 0.05
        layer.enabled: true
        layer.effect: FastBlur {
            radius: 2
        }
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.5; color: "#ff6b52" }
                GradientStop { position: 0.51; color: "transparent" }
            }
            rotation: 90
            width: parent.width
            height: parent.height
        }
    }

    Rectangle {
        id: gridOverlay
        anchors.fill: parent
        opacity: 0.1
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = "rgba(255,107,82,0.2)"
                for (var i = 0; i < width; i += 40) {
                    ctx.beginPath()
                    ctx.moveTo(i, 0)
                    ctx.lineTo(i, height)
                    ctx.stroke()
                }
                for (var j = 0; j < height; j += 40) {
                    ctx.beginPath()
                    ctx.moveTo(0, j)
                    ctx.lineTo(width, j)
                    ctx.stroke()
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        border.color: "#ff6b52"
        border.width: 1
        anchors.margins: 4
        opacity: 0.2
    }

    Column {
        anchors.top: parent.top
        anchors.left: parent.left
        x: 20
        y: 20
        spacing: 5

        Text { text: "SECURITY LEVEL: HIGH"; font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52" }
        Text { text: "SYSTEM: ARCH LINUX"; font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52" }
        Text { text: "KERNEL: " + (sddm.kernelVersion ? sddm.kernelVersion : "Unknown"); font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52" }
        Text { text: "NETWORK: SECURE"; font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52" }
    }

    Column {
        anchors.top: parent.top
        anchors.right: parent.right
        x: -20
        y: 20
        spacing: 5
        Text { text: "LOGIN ATTEMPTS: 3"; font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52" }
        Text { text: "SYSTEM UPTIME: 23:45:12"; font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52" }
        Text { text: "TIME: " + Qt.formatTime(new Date(), "hh:mm:ss"); font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52" }
        Repeater {
            model: 4
            delegate: Text {
                text: Math.floor(Math.random()*90+10) + "." + Math.floor(Math.random()*900+100) + "." + Math.floor(Math.random()*90+10) + "." + Math.floor(Math.random()*900+100)
                font.family: monospaceFont.name
                font.pixelSize: 12
                color: "#ff6b52"
                horizontalAlignment: Text.AlignRight
            }
        }
    }

    LoginBox {
        id: loginForm
        anchors.centerIn: parent
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        x: 20
        y: -20
        spacing: 5
        Text { text: "SYSTEM"; font.family: monospaceFont.name; font.pixelSize: 12; color: "#ff6b52" }
        Rectangle {
            width: 100; height: 4; color: "#1e1e1e"
            Rectangle { width: Math.random() * 100; height: 4; color: "#ff6b52" }
        }
        Text { text: "NETWORK"; font.family: monospaceFont.name; font.pixelSize: 12; color: "#ff6b52" }
        Rectangle {
            width: 100; height: 4; color: "#1e1e1e"
            Rectangle { width: Math.random() * 100; height: 4; color: "#ff6b52" }
        }
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        x: -20
        y: -20
        spacing: 5
        Text {
            text: "MEMORY: " + (sddm.memoryUsed ? (sddm.memoryUsed / 1024).toFixed(2) + "G" : "N/A") + " / " +
                  (sddm.memoryTotal ? (sddm.memoryTotal / 1024).toFixed(2) + "G" : "N/A")
            font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52"
        }
        Text { text: "CPU: " + (sddm.cpuModel ? sddm.cpuModel : "Intel i7"); font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52" }
        Text { text: "TEMP: " + Math.floor(Math.random() * 25 + 40) + "°C"; font.family: monospaceFont.name; font.pixelSize: 14; color: "#ff6b52" }
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        y: -30
        spacing: 5
        Image {
            source: "images/shutdown_icon.png"
            width: 48; height: 48
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                onClicked: sddm.shutdown()
            }
        }
        Text {
            text: "Shutdown"
            font.family: monospaceFont.name
            font.pixelSize: 14
            color: "#ff6b52"
        }
    }

    Text {
        text: "UNAUTHORIZED ACCESS WILL BE TRACED AND REPORTED"
        font.family: monospaceFont.name
        font.pixelSize: 12
        color: "#ff6b52"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        y: -80
    }

    Text {
        text: "USER LOGGED"
        font.family: monospaceFont.name
        font.pixelSize: 14
        color: "#ff6b52"
        anchors.top: parent.top
        anchors.right: parent.right
        x: -20
        y: 20
    }

    Text {
        text: "SDDM ALIVE"
        font.family: monospaceFont.name
        font.pixelSize: 14
        color: "#ff6b52"
        anchors.top: parent.top
        anchors.right: parent.right
        x: -20
        y: 40
    }
}
