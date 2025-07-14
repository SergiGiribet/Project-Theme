import QtQuick 2.15
import SddmComponents 2.0

Rectangle {
    width: 1920
    height: 1080
    color: "black"

    property int sessionIndex: session.index

    TextConstants { id: textConstants }

    // Fondo
    Image {
        anchors.fill: parent
        source: Qt.resolvedUrl("images/Background.jpg")
        fillMode: Image.PreserveAspectCrop
    }

    // Capa de tinte oscuro con matiz violeta
    Rectangle {
        anchors.fill: parent
        color: "#1c003380"
    }

    // Información del sistema (superior izquierda)
    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
        spacing: 4

        Text {
            text: "SYSTEM: ARCH LINUX"
            color: "#00ffff"
            font.pixelSize: 12
        }

        Text {
            text: "KERNEL: 6.1.53"
            color: "#00ffff"
            font.pixelSize: 12
        }

        Text {
            id: systemTime
            text: Qt.formatDateTime(new Date(), "HH:mm:ss")
            color: "#00ffff"
            font.pixelSize: 12
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: systemTime.text = Qt.formatDateTime(new Date(), "HH:mm:ss")
        }
    }

    // Información del sistema (abajo derecha)
    Column {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        spacing: 4

        Text {
            text: "MEMORY: 2.1GB / 8.0GB"
            color: "#ff00ff"
            font.pixelSize: 10
        }

        Text {
            text: "CPU: 2800Mhz  ●  32°C"
            color: "#ff00ff"
            font.pixelSize: 10
        }

        Text {
            text: "UPTIME: 2d 10h 26m"
            color: "#ff00ff"
            font.pixelSize: 10
        }
    }

    // Login Box
    Column {
        anchors.centerIn: parent
        spacing: 10

        // Avatar + Username
        Column {
            spacing: 4
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                width: 80
                height: 80
                radius: 40
                clip: true

                Image {
                    anchors.fill: parent
                    source: Qt.resolvedUrl("images/avatar.png") // Usa tu propia imagen o reemplaza con un icono
                    fillMode: Image.PreserveAspectFit
                }
            }

            Text {
                text: "Girquell"
                font.pixelSize: 22
                color: "white"
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: "Arch Linux"
                font.pixelSize: 14
                color: "#00ffff"
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: systemTime.text
                font.pixelSize: 14
                color: "#00ffff"
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Input de contraseña
        PasswordBox {
            id: pw_entry
            width: 200
            height: 35
            font.pixelSize: 14
            placeholderText: "Password"
            KeyNavigation.tab: loginBtn

            Keys.onPressed: function(event) {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    sddm.login("Girquell", pw_entry.text, sessionIndex)
                    event.accepted = true
                }
            }
        }

        // Botones
        Row {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                width: 80
                height: 30
                color: "#00ffff20"
                radius: 4

                Text {
                    anchors.centerIn: parent
                    text: "BACK"
                    color: "#00ffff"
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: pw_entry.text = ""
                }
            }

            Rectangle {
                id: loginBtn
                width: 80
                height: 30
                color: "#00ffff20"
                radius: 4

                Text {
                    anchors.centerIn: parent
                    text: "LOGIN"
                    color: "#00ffff"
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: sddm.login("Girquell", pw_entry.text, sessionIndex)
                }
            }
        }

        // Apagar
        MouseArea {
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            width: 100
            height: 20
            onClicked: sddm.powerOff()

            Text {
                anchors.centerIn: parent
                text: "⏻ Shutdown"
                color: "#aa00ff"
                font.pixelSize: 12
            }
        }
    }

    Component.onCompleted: {
        pw_entry.focus = true
    }
}
