// Main.qml - SDDM-like login en un solo archivo sin SddmComponents
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import QtQuick.Window 2.15 // Necesario para Window.onVisibilityChanged si quieres manejar el foco al mostrar

Rectangle {
    id: root
    width: 1024
    height: 768
    color: "#000000"

    // Fondo y capa oscura
    Image {
        id: bg
        source: "images/background.jpg" // Asegúrate de que esta ruta sea correcta
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000AA" // Capa semi-transparente oscura sobre el fondo
    }

    // Efecto de Scanline
    Rectangle {
        id: scanlineOverlay
        anchors.fill: parent
        opacity: 0.05 // Más sutil como en la imagen
        layer.enabled: true
        layer.effect: FastBlur {
            radius: 2
        }
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.5; color: "#ff6b52" } // Color de la línea
                GradientStop { position: 0.51; color: "transparent" }
            }
            rotation: 90
        }
    }

    // Efecto de Cuadrícula
    Rectangle {
        id: gridOverlay
        anchors.fill: parent
        opacity: 0.1 // Más sutil como en la imagen
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = "rgba(255,107,82,0.2)" // Color de la cuadrícula
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
            text: "KERNEL: 6.5.3"
            font.pixelSize: 14
            color: "#ff6b52"
        }
        Text {
            text: "# NETWORKS: SECURE"
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
        horizontalAlignment: Text.AlignRight

        Text {
            text: "LOGIN ATTEMPTS: 0"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "SYSTEM UPTIME: 23:45:12" // Esto debería ser dinámico si sddm lo provee
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
        }
        Text {
            // Usamos una expresión JavaScript para obtener la hora actual
            text: "TIME: " + Qt.formatTime(new Date(), "hh:mm:ss")
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
        }
        Item { width: 1; height: 10 } // Espacio
        Text {
            text: "83.695.90.616"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "16.797.56.353"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "19.614.78.952"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "14.624.11.248"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
        }
    }


    // --- CAJA DE LOGIN ---
    Rectangle {
        width: 450
        height: 380
        anchors.centerIn: parent
        color: "#40000000" // Fondo semi-transparente oscuro para la caja
        radius: 10
        border.color: "#ff6b52" // Borde rojo/naranja
        border.width: 1

        Column {
            anchors.centerIn: parent
            spacing: 15
            width: parent.width * 0.8 // Ancho de la columna para centrar los elementos

            Image {
                source: "images/user_icon.png" // Asegúrate de que esta ruta sea correcta
                width: 70
                height: 70
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Nombre de usuario y estado (Girquell, Arch Linux, Online)
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                Text {
                    id: usernameDisplay
                    text: "Girquell" // Nombre de usuario por defecto como en la imagen
                    font.pixelSize: 24
                    font.bold: true
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }
                Text {
                    text: "Arch Linux"
                    font.pixelSize: 16
                    color: "#ff6b52"
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 5
                    Rectangle {
                        width: 10
                        height: 10
                        radius: 5
                        color: "#00ff00" // Círculo verde para "Online"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "ONLINE"
                        font.pixelSize: 14
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }


            TextField {
                id: usernameField
                // No hay placeholderText aquí, el nombre de usuario ya está "escrito"
                text: "Girquell" // El texto ya viene pre-rellenado como en la imagen
                readOnly: true // Para que no se pueda editar si ya está pre-rellenado
                width: 300
                height: 45
                font.pixelSize: 20
                color: "white"
                horizontalAlignment: TextInput.AlignHCenter
                background: Rectangle {
                    radius: 5
                    color: "#202020"
                    border.color: "#ff6b52" // Borde del color de énfasis
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
                horizontalAlignment: TextInput.AlignHCenter
                background: Rectangle {
                    radius: 5
                    color: "#202020"
                    border.color: "#ff6b52" // Borde del color de énfasis
                    border.width: 1
                }
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Enter || event.key === Qt.Key_Return) {
                        loginButton.clicked() // Activa el botón de login al presionar Enter
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
                        color: parent.pressed ? "#ff6b52" : "white" // Cambia el color del texto al presionar

                        verticalAlignment: Text.AlignVCenter
                    }
                    background: Rectangle {
                        radius: 5
                        color: "#303030"
                        border.color: "#ff6b52"
                        border.width: 1
                    }
                    onClicked: {
                        // Aquí deberías definir qué significa "BACK" en tu contexto SDDM.
                        // Podría ser limpiar los campos o regresar a una selección de usuario.
                        passwordField.text = "" // Solo limpiar la contraseña por ahora
                        passwordField.forceActiveFocus() // Enfocar la contraseña de nuevo
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
                        color: parent.pressed ? "white" : "black" // Cambia el color del texto al presionar

                        verticalAlignment: Text.AlignVCenter
                    }
                    background: Rectangle {
                        radius: 5
                        color: "#ff6b52" // Color de fondo del botón LOGIN
                    }
                    onClicked: {
                        if (typeof sddm !== "undefined") {
                            sddm.login(usernameField.text, passwordField.text, sddm.session)
                        } else {
                            console.log("Simulando login para usuario:", usernameField.text)
                            // En un entorno de prueba, podrías mostrar un mensaje o simular un éxito/fallo
                        }
                    }
                }
            }
        }

        Text {
            id: sysActiveText
            text: "SYS ACTIVE"
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

        y: -40 // Ajusta la posición para que quede más abajo como en la imagen
    }

    // --- INFORMACIÓN INFERIOR DERECHA (Sistema, Red, Memoria, CPU, Temp) ---
    Column {
        id: footerRight
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        x: -20
        y: -20
        spacing: 5
        horizontalAlignment: Text.AlignRight

        Text {
            text: "MEMORY: 2.1GB / 8.0GB" // Esto debería ser dinámico si sddm lo provee
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "CPU: INTEL i7-6750" // Esto debería ser dinámico si sddm lo provee
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
        }
        Text {
            text: "TEMP: 45°C" // Esto debería ser dinámico si sddm lo provee
            font.pixelSize: 14
            color: "#ff6b52"
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

    // Asegurarse de que el campo de contraseña tenga el foco al iniciar
    Window.onVisibilityChanged: {
        if (visibility === Window.Visible) {
            passwordField.forceActiveFocus()
        }
    }
}