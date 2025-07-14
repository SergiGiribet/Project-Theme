// Main.qml
import QtQuick 2.0
import SDDMComponents 1.0 // Crucial for SDDM's functions (login, shutdown etc.)
import "components" // To import your custom QML components

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#000000" // Fallback black background

    // 1. Load Custom Font
    // Make sure 'fonts/YourMonospaceFont.ttf' exists in your theme directory
    FontLoader {
        id: monospaceFont
        source: "fonts/YourMonospaceFont.ttf"
    }

    // 2. Background Image
    Image {
        source: "images/background.jpg" // Make sure this image exists in images/
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        // opacity: 0.9 // Adjust if you want it slightly less vibrant
    }

    // 3. Login Box (using your component)
    LoginBox {
        id: loginForm
        anchors.centerIn: parent // Centers the entire login box on the screen
    }

    // 4. Top-Left System Information
    Column {
        anchors.top: parent.top
        anchors.left: parent.left
        x: 20 // Margin from left edge
        y: 20 // Margin from top edge
        spacing: 5

        Text {
            text: "SYSTEM: ABP Linux"
            font.family: monospaceFont.name
            font.pixelSize: 16
            color: "#ff8800"
        }
        Text {
            // sddm.kernelVersion is a dynamic property provided by SDDM
            text: "Kernel: " + (sddm.kernelVersion ? sddm.kernelVersion : "Unknown")
            font.family: monospaceFont.name
            font.pixelSize: 16
            color: "#ff8800"
        }
        Text {
            // Note: "FPS" is usually for games. This might be a placeholder or date.
            // If you want a static date: Qt.formatDate(new Date(), "yyyy.MM.dd")
            text: "FPS: 20.12.13" // Hardcoded as in your image, if it's not a real FPS counter
            font.family: monospaceFont.name
            font.pixelSize: 16
            color: "#ff8800"
        }
    }

    // 5. Bottom-Right System Information
    Column {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        x: -20 // Margin from right edge
        y: -20 // Margin from bottom edge
        spacing: 5
        horizontalAlignment: Text.AlignRight // Align text to the right within the column

        Text {
            // sddm.memoryUsed and sddm.memoryTotal are dynamic properties
            text: "MEMORY: " +
                  (sddm.memoryUsed ? (sddm.memoryUsed / 1024).toFixed(2) + "G" : "N/A") + " / " +
                  (sddm.memoryTotal ? (sddm.memoryTotal / 1024).toFixed(2) + "G" : "N/A")
            font.family: monospaceFont.name
            font.pixelSize: 16
            color: "#ff8800"
        }
        Text {
            // sddm.cpuModel is a dynamic property
            text: "CPU: " + (sddm.cpuModel ? sddm.cpuModel : "Intel XXXXXX")
            font.family: monospaceFont.name
            font.pixelSize: 16
            color: "#ff8800"
        }
    }

    // 6. Shutdown Button/Icon (bottom center)
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        y: -30 // Adjust position from bottom
        spacing: 10

        Image {
            id: shutdownIcon
            source: "images/shutdown_icon.png" // Make sure this image exists
            width: 48 // Adjust size
            height: 48 // Adjust size
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: sddm.shutdown() // Action to shutdown
            }
        }
        Text {
            text: "Shutdown"
            font.family: monospaceFont.name
            font.pixelSize: 14
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    // Optional: Other texts/logos from your image (bottom left, top right)
    Text {
        text: "USER LOGGED" // Hardcoded placeholder
        font.family: monospaceFont.name
        font.pixelSize: 14
        color: "#ff8800"
        anchors.top: parent.top
        anchors.right: parent.right
        x: -20
        y: 20
    }

    Text {
        text: "SDDM ALIVE" // Hardcoded placeholder
        font.family: monospaceFont.name
        font.pixelSize: 14
        color: "#ff8800"
        anchors.top: parent.top
        anchors.right: parent.right
        x: -20
        y: 40
    }

    // ... (any other elements you need)
}