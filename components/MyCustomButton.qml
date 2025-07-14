// components/MyCustomButton.qml
import QtQuick 2.0

Rectangle {
    id: buttonRect
    property alias text: buttonText.text
    property alias clicked: mouseArea.clicked // Expose clicked signal
    width: 100
    height: 40
    color: "#ff8800" // Orange button color
    radius: 5

    Text {
        id: buttonText
        text: "Button"
        color: "white"
        font.pixelSize: 18
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        // Define hover effects, press effects etc.
    }
}