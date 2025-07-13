// components/LoginBox.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.sddm 1.0

Column {
    spacing: 12
    anchors.horizontalCenter: parent.horizontalCenter

    Image {
        source: userModel.selectedUser.avatar
        width: 96; height: 96
        radius: 48
        smooth: true
    }

    Text {
        text: userModel.selectedUser.name
        font.pixelSize: 24
        font.bold: true
        color: "#ffffff"
        horizontalAlignment: Text.AlignHCenter
    }

    PasswordField {
        id: password
        width: 260
        placeholderText: "Password"
        font.family: "monospace"
        color: "#00ffff"
    }

    Row {
        spacing: 16
        Button {
            text: "BACK"
            onClicked: sddm.goToUserList()
        }
        Button {
            text: "LOGIN"
            onClicked: sddm.login(userModel.selectedUser.name, password.text)
        }
    }

    Button {
        text: "Shutdown"
        onClicked: sddm.powerOff()
    }
}
