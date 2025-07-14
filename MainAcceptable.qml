// Main.qml - SDDM-like login in un solo archivo sin SddmComponents
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: 1024
    height: 768
    color: "#000000"

    Image {
        id: bg
        source: "images/background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
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

    // LOGIN BOX
    Rectangle {
        width: 450
        height: 380
        anchors.centerIn: parent
        color: "#40000000"
        radius: 10

        Column {
            anchors.centerIn: parent
            spacing: 15

            Image {
                source: "images/user_icon.png"
                width: 70
                height: 70
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item { width: 1; height: 20 }

            TextField {
                id: usernameField
                placeholderText: "girquell"
                width: 300
                height: 45
                font.pixelSize: 20
                color: "white"
                background: Rectangle {
                    radius: 5
                    color: "#202020"
                    border.color: "#ff8800"
                    border.width: 1
                }
            }

            TextField {
                id: passwordField
                placeholderText: "Password"
                echoMode: TextInput.Password
                width: 300
                height: 45
                font.pixelSize: 20
                color: "white"
                background: Rectangle {
                    radius: 5
                    color: "#202020"
                    border.color: "#ff8800"
                    border.width: 1
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Button {
                    text: "BACK"
                    width: 120
                    height: 45
                    font.pixelSize: 20
                    background: Rectangle {
                        radius: 5
                        color: "#303030"
                        border.color: "#ff8800"
                        border.width: 1
                    }
                    onClicked: {
                        usernameField.text = ""
                        passwordField.text = ""
                    }
                }

                Button {
                    text: "LOGIN"
                    width: 120
                    height: 45
                    font.pixelSize: 20
                    background: Rectangle {
                        radius: 5
                        color: "#ff8800"
                    }
                    onClicked: {
                        if (typeof sddm !== "undefined") {
                            sddm.login(usernameField.text, passwordField.text, sddm.session)
                        } else {
                            console.log("Simulando login: ", usernameField.text)
                        }
                    }
                }
            }
        }
    }

    Text {
        text: "UNAUTHORIZED ACCESS WILL BE TRACED AND REPORTED"
        font.pixelSize: 12
        color: "#ff6b52"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        y: -80
    }

    Text {
        text: "SDDM ALIVE"
        font.pixelSize: 14
        color: "#ff6b52"
        anchors.top: parent.top
        anchors.right: parent.right
        x: -20
        y: 40
    }
} 
