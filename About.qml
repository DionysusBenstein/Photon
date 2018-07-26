import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3

Popup {
    id: popup
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 426; height: 320
    parent: Overlay.overlay
    modal: true
    focus: true
    clip:  true
    padding: 0

    Rectangle {
        anchors.fill: parent
        scale: 1.6
        rotation: 147
        radius: 2
        gradient: Gradient {
            GradientStop { position: 1.0; color: "#FFE53B" }
            GradientStop { position: 0.0; color: "#FF2525" }
        }
    }

    Image {
        id: appLogo
        anchors.centerIn: parent
        source: "images/icons/youtube.svg"
        sourceSize.width:  120
        sourceSize.height: 120
    }

    Button {
        id: doneButton
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin:  8
            bottomMargin: 2
        }

        flat: true
        text: qsTr("OK")
        Material.theme: Material.Dark
        Material.foreground: "white"
        onClicked: popup.close()
    }
}
