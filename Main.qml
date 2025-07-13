// Main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.sddm 1.0

Rectangle {
    width: 1366
    height: 768

    // Fondo anime
    Image {
        anchors.fill: parent
        source: "images/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    // Scanlines
    Canvas {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.fillStyle = "rgba(0,0,0,0.05)";
            for (var y = 0; y < height; y += 2) {
                ctx.fillRect(0, y, width, 1);
            }
        }
    }

    // Información arriba a la izquierda
    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        spacing: 4

        Text { text: "SYSTEM: ARCH LINUX"; font.family: "monospace"; color: "#00ffff" }
        Text { text: "KERNEL: 6.1.x"; color: "#00ffff" }
        Text { text: "TIME: " + Qt.formatTime(new Date(), "hh:mm:ss"); color: "#00ffff" }
    }

    // Información abajo a la derecha
    Column {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        spacing: 4

        Text { text: "MEMORY: 2.1GB / 8.0GB"; color: "#00ffff" }
        Text { text: "CPU: 9%@52°C"; color: "#00ffff" }
        Text { text: "UPTIME: 2d 10h"; color: "#00ffff" }
    }

    // Login centrado
    Loader {
        anchors.centerIn: parent
        source: "components/LoginBox.qml"
    }
}
