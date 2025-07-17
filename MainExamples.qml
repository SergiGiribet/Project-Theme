import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import QtQuick.Window 2.15

Rectangle {
    id: root
    width: 1024
    height: 768
    color: "#181313" // Dark background color from the image

    // Timer para actualizar la hora y la fecha si no se usa sddm.time/date
    Timer {
        id: dateTimeTimer
        interval: 1000 // Actualizar cada segundo
        running: true
        repeat: true
        onTriggered: {
            // This will force re-evaluation of time and date texts
            // if they are not automatically updated by sddm.
            // For real SDDM, it's not strictly necessary if sddm.time/date are reactive.
        }
    }

    // Fondo (no se ve una imagen de fondo en la captura, solo un color oscuro)
    // Si se quisiera usar una imagen como la original (con efectos de brillo/partículas),
    // se necesitaría ajustar la fuente de la imagen y posibles efectos.
    // Para esta similitud, un color sólido oscuro es suficiente.

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
            text: "● SYSTEM: ARCH LINUX" // Added bullet point
            font.pixelSize: 14
            color: "#ff6b52"
        }
        Text {
            text: "● KERNEL: 6.5.3"
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

        Text {
            text: "LOGIN ATTEMPTS: 0"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width // Adjust width to content
        }
        Text {
            // SDDM exposes sddm.uptime if available. Otherwise, a script is needed.
            text: "SYSTEM UPTIME: " + (typeof sddm !== "undefined" && sddm.uptime ? sddm.uptime : "23:45:12") // Static for example
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width
        }
        Text {
            // SDDM exposes sddm.time. If undefined (e.g., qmlscene), use Qt.formatTime(new Date()).
            text: "TIME: " + (typeof sddm !== "undefined" && sddm.time ? sddm.time : Qt.formatTime(new Date(), "hh:mm:ss"))
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width
        }
        Item { width: 1; height: 10 } // Espacio
        Text {
            text: "83.695.90.616"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width
        }
        Text {
            text: "16.797.56.353"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width
        }
        Text {
            text: "19.614.78.952"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width
        }
        Text {
            text: "14.624.11.248"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width
        }
    }


    // --- CAJA DE LOGIN ---
    Rectangle {
        width: 450
        height: 380
        anchors.centerIn: parent
        color: "#00000000" // Fully transparent background for the box
        // No radius or border for the main login box in the image

        Column {
            anchors.centerIn: parent
            spacing: 15
            width: parent.width * 0.8 // Ancho de la columna para centrar los elementos

            Image {
                // You'll need to provide this image. It's a silhouette of a person.
                // For SDDM themes, place it in the 'assets' folder (e.g., yourtheme/assets/user_icon_orange.png)
                source: "images/user_icon_.png" // Path to a user icon that matches the image, assume it's in assets
                width: 150 // Adjusted size to match the image better
                height: 150
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                // If SDDM exposes user avatars, you could use something like:
                // source: (typeof sddm !== "undefined" && sddm.users.length > 0 && sddm.users[sddm.currentUser] && sddm.users[sddm.currentUser].face) ? sddm.users[sddm.currentUser].face : "qrc:///sddm/themes/theme_name/assets/user_icon_orange.png"
                opacity: 0.8 // Slightly transparent to match the image
            }

            // Username display
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                Text {
                    id: usernameDisplay
                    text: typeof userModel !== "undefined" && userModel.lastUser ? userModel.lastUser.toUpperCase() : "UnKnown"
                    font.pixelSize: 28 // Larger font for username
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
                        color: "#00ff00" // Green circle for "Online"
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

            // Username Field not visible by default, only used for input
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


            // Password Field
            TextField {
                id: passwordField
                focus: true
                placeholderText: "Password"
                echoMode: TextInput.Password
                width: 300 // Match the width of buttons
                height: 45
                font.pixelSize: 20
                color: "white"
                horizontalAlignment: TextInput.AlignHCenter // Center placeholder and input text
                leftPadding: 0 // Remove default padding for centered text
                rightPadding: 0

                background: Item {
                    width: parent.width
                    height: parent.height

                    Rectangle {
                        // This is the bottom border / underline
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
                        color: "#00000000" // Transparent background
                        border.color: "#ff6b52" // Orange-red border
                        border.width: 1
                        radius: 0 // No radius
                    }
                    onClicked: {
                        passwordField.text = "" // Clear password field
                        // If there were multiple users, this would ideally go back to user selection
                        // For this single user setup, it just clears password.
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
                        color: "#ff6b52" // Orange-red solid background
                        radius: 0 // No radius
                    }
                    onClicked: {
                        if (typeof sddm !== "undefined") {
                            sddm.login(usernameDisplay.text, passwordField.text, sddm.session) // Use usernameDisplay.text for username
                        } else {
                            console.log("Simulando login para usuario:", usernameDisplay.text)
                        }
                    }
                }
            }
        }

        Text {
            id: secureLoginText
            text: "SECURE LOGIN ◄"
            font.pixelSize: 14
            color: "#ff6b52"
            anchors.top: parent.top
            anchors.left: parent.left
            x: 15
            y: 15
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

    // --- Shutdown Button ---
    Button {
        id: shutdownButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        y: -90 // Adjust position to be above the warning text
        width: 150 // Example width
        height: 50 // Example height
        contentItem: Row {
            spacing: 10
            anchors.centerIn: parent
            Image {
                // This would be the icon for shutdown. You'd need to provide it.
                // Place it in your theme's assets folder (e.g., yourtheme/assets/shutdown_icon.png)
                source: "qrc:///sddm/themes/theme_name/assets/shutdown_icon.png" // Placeholder for a shutdown icon
                width: 24
                height: 24
                fillMode: Image.PreserveAspectFit
            }
            Text {
                text: "Shutdown"
                font.pixelSize: 16
                font.bold: true
                color: "#ff6b52"
                verticalAlignment: Text.AlignVCenter
            }
        }
        background: Rectangle {
            color: "#00000000" // Transparent background
        }
        onClicked: {
            if (typeof sddm !== "undefined") {
                sddm.powerOff() // SDDM function to power off the system
            } else {
                console.log("Simulating shutdown...")
            }
        }
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
            text: "MEMORY: 2.1GB / 8.0GB"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width
        }
        Text {
            text: "CPU: INTEL i7-6750"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width
        }
        Text {
            text: "TEMP: 45°C"
            font.pixelSize: 14
            color: "#ff6b52"
            horizontalAlignment: Text.AlignRight
            width: childrenRect.width
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

    // Ensure password field has focus on visibility change
    Window.onVisibilityChanged: {
        if (visibility === Window.Visible) {
            passwordField.forceActiveFocus()
        }
    }
}