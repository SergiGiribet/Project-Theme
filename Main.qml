import QtQuick 2.12
import QtQuick.Controls 2.12
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1366
    height: 768
    color: "#000000"

    property int sessionIndex: session.index

    // Fondo
    Image {
        anchors.fill: parent
        source: Qt.resolvedUrl("images/Background.jpg")
        fillMode: Image.PreserveAspectCrop
    }

    // Capa oscura translúcida
    Rectangle {
        anchors.fill: parent
        color: "#0a0a2a"
        opacity: 0.6
    }

    // Panel central
    Rectangle {
        width: 500
        height: 400
        anchors.centerIn: parent
        color: "#111827"
        radius: 10
        opacity: 0.85

        Column {
            spacing: 20
            anchors.centerIn: parent

            // Avatar y nombre
            Column {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    width: 96
                    height: 96
                    radius: 48
                    color: "#444"
                    border.color: "#aaa"

                    Image {
                        anchors.fill: parent
                        source: userModel.hasUserImage(userModel.lastUser) ?
                            userModel.userImage(userModel.lastUser) :
                            "qrc:/DefaultAvatar.png"
                        fillMode: Image.PreserveAspectCrop
                        smooth: true
                        clip: true
                    }
                }

                Text {
                    text: userModel.lastUser
                    color: "#fff"
                    font.pixelSize: 22
                    font.bold: true
                    font.family: "Monospace"
                }

                Text {
                    text: "Arch Linux"
                    color: "#aaa"
                    font.pixelSize: 14
                    font.family: "Monospace"
                }

                Text {
                    text: Qt.formatTime(new Date(), "hh:mm:ss")
                    font.pixelSize: 14
                    color: "#60d0ff"
                    font.family: "Monospace"
                }
            }

            // Entrada de contraseña
            TextField {
                id: pw_entry
                width: 300
                placeholderText: "Password"
                echoMode: TextInput.Password
                color: "#ffffff"
                font.pixelSize: 14
                font.family: "Monospace"
                background: Rectangle {
                    color: "#222"
                    radius: 4
                }

                Keys.onReturnPressed: {
                    sddm.login(userModel.lastUser, pw_entry.text, sessionIndex)
                }
            }

            // Botón de login
            Button {
                text: "LOGIN"
                width: 100
                height: 35
                font.bold: true
                font.pixelSize: 14
                background: Rectangle {
                    color: "#3b82f6"
                    radius: 6
                }
                onClicked: sddm.login(userModel.lastUser, pw_entry.text, sessionIndex)
            }

            // Apagar
            Button {
                text: "Shutdown"
                font.pixelSize: 12
                onClicked: sddm.powerOff()
                background: Rectangle {
                    color: "#ef4444"
                    radius: 6
                }
            }
        }
    }

    // Esquina superior izquierda - sistema
    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
        spacing: 2

        Text { text: "SYSTEM: ARCH LINUX"; color: "#66ccff"; font.pixelSize: 10; font.family: "Monospace" }
        Text { text: "KERNEL: 6.1.5"; color: "#66ccff"; font.pixelSize: 10; font.family: "Monospace" }
        Text { text: "TIME: " + Qt.formatTime(new Date(), "hh:mm:ss"); color: "#66ccff"; font.pixelSize: 10; font.family: "Monospace" }
    }

    // Esquina inferior derecha - stats
    Text {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        color: "#cccccc"
        font.pixelSize: 10
        font.family: "Monospace"
        text: "MEMORY: 2.1GB / 8.0GB\nCPU: 28%  |  52ºC\nUPTIME: 2d 10h 26m"
    }
}
