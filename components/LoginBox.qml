// components/LoginBox.qml
import QtQuick 2.0
import SDDMComponents 1.0 // For TextField, PasswordField, Button

Item {
    id: loginBoxRoot
    property alias usernameText: usernameField.text
    property alias passwordText: passwordField.text

    width: 450 // Adjust width as needed
    height: 380 // Adjust height as needed

    // Background rectangle for the login box
    Rectangle {
        anchors.fill: parent
        color: "#40000000" // Semi-transparent black (RRGGBBAA)
        radius: 10
    }

    Column {
        anchors.centerIn: parent
        spacing: 15 // Spacing between elements in the column

        // User Icon
        Image {
            source: "images/user_icon.png" // Path relative to Main.qml
            width: 70
            height: 70
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            // opacity: 0.8 // Optional: slightly fade the icon
        }

        // Spacer for visual separation
        Item { width: 1; height: 20 }

        // Username Field
        SDDMComponents.TextField {
            id: usernameField
            width: 300 // Adjust width
            height: 45 // Adjust height
            placeholderText: "girquell" // The text you saw in the image
            placeholderTextColor: "#AAAAAA"
            font.pixelSize: 20
            color: "white" // Text color
            background: Rectangle {
                radius: 5
                color: "#202020" // Background color of the text field
                border.color: "#ff8800" // Orange border
                border.width: 1
            }
        }

        // Password Field
        SDDMComponents.PasswordField {
            id: passwordField
            width: 300 // Adjust width
            height: 45 // Adjust height
            placeholderText: "Password"
            placeholderTextColor: "#AAAAAA"
            font.pixelSize: 20
            color: "white" // Text color
            background: Rectangle {
                radius: 5
                color: "#202020"
                border.color: "#ff8800"
                border.width: 1
            }
        }

        // Buttons
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            // BACK Button
            SDDMComponents.Button { // Using a generic SDDM Button for simplicity
                id: backButton
                width: 120
                height: 45
                text: "BACK"
                font.pixelSize: 20
                color: "#ff8800" // Button text color
                background: Rectangle {
                    radius: 5
                    color: "#303030" // Button background color
                    border.color: "#ff8800"
                    border.width: 1
                }
                onClicked: {
                    // You might want to clear fields or navigate back
                    // depending on SDDM's multi-user setup if applicable.
                    // For a simple single-user setup, it might just clear fields.
                    usernameField.text = ""
                    passwordField.text = ""
                }
            }

            // LOGIN Button
            SDDMComponents.Button {
                id: loginButton
                width: 120
                height: 45
                text: "LOGIN"
                font.pixelSize: 20
                color: "white" // Button text color
                background: Rectangle {
                    radius: 5
                    color: "#ff8800" // Orange background
                }
                onClicked: {
                    sddm.login(usernameField.text, passwordField.text, sddm.session)
                    // The sddm.session argument is important for proper session handling
                }
            }
        }
    }
}