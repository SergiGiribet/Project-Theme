// Main.qml - SDDM-like login en un solo archivo sin SddmComponents
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import QtQuick.Window 2.15

Rectangle {
    id: root
    width: 1024
    height: 768
    color: "#000000"

    // Timer para actualizar la hora y la fecha si no se usa sddm.time/date
    // En un entorno SDDM real, sddm.time/date se actualizarán automáticamente.
    Timer {
        id: dateTimeTimer
        interval: 1000 // Actualizar cada segundo
        running: true
        repeat: true
        onTriggered: {
            // Esto forzará la reevaluación de los textos de hora y fecha
            // si no se están actualizando automáticamente por sddm.
            // Para SDDM real, no es estrictamente necesario si sddm.time/date son reactivos.
        }
    }

    // Fondo y capa oscura
    Image {
        id: bg
        source: "images/background.jpg" // Asegúrate de que esta ruta sea correcta
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill: parent
        color: "#b9000000" // Capa semi-transparente oscura sobre el fondo
    }

    // --- INFORMACIÓN DE CABECERA IZQUIERDA ---
    Column {
        id: headerLeft
        anchors.top: parent.top
        anchors.left: parent.left
        x: 20
        y: 20
        spacing: 5

        Text {
            text: "SECURITY LEVEL: HIGH"
            font.pixelSize: 14
            color: "#ff6b52"
        }
        Text {
            text: "SYSTEM: ARCH LINUX"
            font.pixelSize: 14
            color: "#ff6b52"
        }
        Text {
            text: "KERNEL: 6.5.3" // Este valor es estático, SDDM no suele exponerlo.
                                   // Podrías obtenerlo vía script en un SDDM más complejo.
            font.pixelSize: 14
            color: "#ff6b52"
        }
        Text {
            text: "# NETWORKS: SECURE" // Este valor es estático. Podrías obtener el estado de red vía script.
            font.pixelSize: 14
            color: "#ff6b52"
        }
    }

    // --- INFORMACIÓN DE CABECERA DERECHA ---
    Column {
        id: headerRight
        anchors.top: parent.top
        anchors.right: parent.right
        x: -20
        y: 20
        spacing: 5

        Text {
            text: "LOGIN ATTEMPTS: 0" // Este valor es estático. SDDM no suele exponerlo directamente.
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
        Text {
            // SDDM expone sddm.uptime si está disponible. Si no, necesitarías un script.
            text: "SYSTEM UPTIME: " + (typeof sddm !== "undefined" && sddm.uptime ? sddm.uptime : "00:00:00")
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
        Text {
            // SDDM expone sddm.time. Si no está definido (ej. qmlscene), usamos Qt.formatTime(new Date()).
            text: "TIME: " + (typeof sddm !== "undefined" && sddm.time ? sddm.time : Qt.formatTime(new Date(), "hh:mm:ss"))
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
        Item { width: 1; height: 10 } // Espacio
        Text {
            // Las IPs son estáticas aquí. Para obtener IPs reales, necesitarías un script del sistema
            // y una forma de pasar esa información al QML, lo cual no es trivial sin SddmComponents.
            text: "83.695.90.616"
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "16.797.56.353"
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "19.614.78.952"
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "14.624.11.248"
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
    }


    // --- CAJA DE LOGIN ---
    Rectangle {
        width: 450
        height: 380
        anchors.centerIn: parent
         color: "#00000000" // Fondo semi-transparente oscuro para la caja
        radius: 10
        // border.color: "#ff6b52" // Borde rojo/naranja
        //border.width: 1

        Column {
            anchors.centerIn: parent
            spacing: 15
            width: parent.width * 0.8 // Ancho de la columna para centrar los elementos

            Image {
                source: "images/user_icon.png" // Asegúrate de que esta ruta sea correcta
                width: 200
                height: 200
                fillMode: Image.PreserveAspectFit
                // Si SDDM expone avatares de usuario, podrías usar algo como:
                // source: (typeof sddm !== "undefined" && sddm.users.length > 0 && sddm.users[sddm.currentUser] && sddm.users[sddm.currentUser].face) ? sddm.users[sddm.currentUser].face : "images/user_icon.png"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Nombre de usuario y estado (siempre "UnKnown" y editable)
            Column {
                anchors.horizontalCenter: parent.horizontalCenter // Centra la columna entera
                spacing: 5
                Text {
                    id: usernameDisplay
                    text: typeof userModel !== "undefined" && userModel.lastUser ? userModel.lastUser.toUpperCase() : "UnKnown"
                    font.pixelSize: 24
                    font.bold: true
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }
                Text {
                    text: "Arch Linux" // Este valor es estático.
                    font.pixelSize: 16
                    color: "#ff6b52"
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter // Centra la fila entera
                    spacing: 5
                    Rectangle {
                        width: 10
                        height: 10
                        radius: 5
                        color: "#00ff00" // Círculo verde para "Online"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "ONLINE" // Este valor es estático. Necesitarías un script para el estado de red.
                        font.pixelSize: 14
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            TextField {
                id: usernameField
                text: userModel.lastUser
                readOnly: false // Es editable para que el usuario pueda escribir
                width: 300
                height: 45
                font.pixelSize: 20
                color: "white"
                horizontalAlignment: TextInput.AlignHCenter
                background: Rectangle {
                    radius: 5
                    color: "#202020"
                    border.color: "#ff6b52"
                    border.width: 1
                }
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Enter || event.key === Qt.Key_Return) {
                        passwordField.forceActiveFocus() // Pasa el foco al campo de contraseña al presionar Enter
                        event.accepted = true
                    }
                }
                visible: false // Oculta el nombre de usuario y estado por defecto                
            }

            TextField {
                id: passwordField
                focus: true // Foco inicial en el campo de contraseña
                placeholderText: "Password"
                echoMode: TextInput.Password
                width: 300
                height: 45
                font.pixelSize: 20
                color: "white"
                horizontalAlignment: TextInput.AlignHLeft

                background: Item {
                    width: parent.width
                    height: parent.height

                    Rectangle {
                        anchors.fill: parent
                        color: "#202020"
                        radius: 5
                    }

                    Rectangle {
                        // Este es el borde inferior
                        width: parent.width
                        height: 1
                        color: "#ff6b52"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                    }
                }

                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                        loginButton.clicked()
                        event.accepted = true
                    }
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
                    font.bold: true
                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        color:"#ff6b52"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    background: Rectangle {
                        // radius: 5
                        color: "#303030"
                        // border.color: "#ff6b52"
                        // border.width: 1
                    }
                    onClicked: {
                        passwordField.text = "" // Limpia el campo de contraseña
                        usernameField.forceActiveFocus() // Vuelve el foco al campo de usuario
                    }
                }

                Button {
                    id: loginButton
                    text: "LOGIN"
                    width: 120
                    height: 45
                    font.pixelSize: 20
                    font.bold: true
                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    background: Rectangle {
                        //radius: 5
                        color: "#ff6b52"
                    }
                    onClicked: {
                        if (typeof sddm !== "undefined") {
                            sddm.login(usernameField.text, passwordField.text, sddm.session)
                        } else {
                            console.log("Simulando login para usuario:", usernameField.text)
                        }
                    }
                }
            }
        }

        Text {
            id: sysActiveText
            text: "SYS ACTIVE ◄"
            font.pixelSize: 14
            color: "#ff6b52"
            anchors.top: parent.top
            anchors.right: parent.right
            x: -15
            y: 15
        }
    }

    // Texto inferior de advertencia
    Text {
        text: "UNAUTHORIZED ACCESS WILL BE TRACED AND REPORTED"
        font.pixelSize: 12
        color: "#ff6b52"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        y: -40
    }

    // --- INFORMACIÓN INFERIOR DERECHA (Sistema, Red, Memoria, CPU, Temp) ---
    Column {
        id: footerRight
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        x: -20
        y: -20
        spacing: 5

        Text {
            // Estos valores son estáticos. Para hacerlos reales, necesitarías un script externo
            // y un mecanismo en QML para leer la salida de ese script (ej. un SddmComponents.SystemStatus
            // o un modelo JavaScript que se actualice periódicamente).
            text: "MEMORY: 2.1GB / 8.0GB"
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "CPU: INTEL i7-6750"
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "TEMP: 45°C"
            font.pixelSize: 14
            color: "#ff6b52"
            width: parent.width
            horizontalAlignment: Text.AlignRight
        }
        Item { width: 1; height: 10 } // Espacio
        Row {
            anchors.right: parent.right
            spacing: 5
            Text {
                text: "SYSTEM"
                font.pixelSize: 14
                color: "#ff6b52"
            }
            Rectangle {
                width: 50
                height: 1
                color: "#ff6b52"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Row {
            anchors.right: parent.right
            spacing: 5
            Text {
                text: "NETWORK"
                font.pixelSize: 14
                color: "#ff6b52"
            }
            Rectangle {
                width: 50
                height: 1
                color: "#ff6b52"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    // Asegurarse de que el campo de usuario tenga el foco al iniciar
    Window.onVisibilityChanged: {
        if (visibility === Window.Visible) {
            passwordField.forceActiveFocus() // Siempre le damos el foco al campo de usuario
        }
    }
}

    