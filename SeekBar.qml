import QtQuick 2.11
import QtMultimedia 5.9
import QtQuick.Controls 2.4

Slider {
    id: control
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        leftMargin: isMaximize() || isFullScreen() ? 18 : 6
        rightMargin: isMaximize() || isFullScreen() ? 18 : 6
        bottomMargin: isMaximize() || isFullScreen() ? (control.pressed || control.hovered ? 39.5 : 50) : (control.pressed || control.hovered ? 25 : 32)
    }

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        width: control.availableWidth
        height: isMaximize() || isFullScreen() ? (control.pressed || control.hovered ? 8 : 5) : (control.pressed || control.hovered ? 5 : 3)
        color: "#C0C0C0"

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: primaryColor
        }
    }

    handle: Rectangle {
        id: handle
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: isMaximize() || isFullScreen() ? (control.pressed || control.hovered ? 20 : 0) : (control.pressed || control.hovered ? 13 : 0)
        implicitHeight: isMaximize() || isFullScreen() ? (control.pressed || control.hovered ? 20 : 0) : (control.pressed || control.hovered ? 13 : 0)
        radius: implicitWidth / 2
        color: primaryColor
    }

    onValueChanged: {
        player.seek(player.duration * control.value)
        videoArea.focus = true
    }
}
