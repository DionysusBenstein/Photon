import QtQuick 2.11
import QtQuick.Controls 2.4

Slider {
    id: control
    width: isMaximize() || isFullScreen() ? 90 : 64
    anchors {
        left: playButton.right
        bottom: parent.bottom
        leftMargin: isMaximize() || isFullScreen() ? 30 : 10
        bottomMargin: isMaximize() || isFullScreen() ? 12 : 6
    }

    value: player.volume
    background: Rectangle {
        id: background
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        width: control.availableWidth
        height: isMaximize() || isFullScreen() ? 4 : 3
        color: "#f2f2f2"
        opacity: 0.21
    }

    Rectangle {
        width: control.visualPosition * background.width
        anchors {
            left: background.left
            top: background.top
            bottom: background.bottom
        }
        color: "#f2f2f2"
    }

    handle: Rectangle {
        id: handle
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: isMaximize() || isFullScreen() ? 18 : 13
        implicitHeight: isMaximize() || isFullScreen() ? 18 : 13
        radius: implicitWidth / 2
        color: "#f2f2f2"
    }
}
