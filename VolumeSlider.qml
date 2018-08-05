/*******************************************************************/

/* Original File Name: VolumeSlider.qml                            */

/* Date: 18-07-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Слайдер, регулирующий громкость медиафайла.        */

/*******************************************************************/

import QtQuick 2.11
import "utils.js" as Utils
import QtQuick.Controls 2.4

Slider {
    id: control
    width: Utils.isMaximize() || Utils.isFullScreen() ? 90 : 64
    anchors {
        left: playButton.right
        bottom: parent.bottom
        leftMargin:   Utils.isMaximize() || Utils.isFullScreen() ? 30 : 10
        bottomMargin: Utils.isMaximize() || Utils.isFullScreen() ? 12 : 6
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        enabled: false
    }

    background: Rectangle {
        id: background
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        width: control.availableWidth
        height: Utils.isMaximize() || Utils.isFullScreen() ? 4 : 3
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
        implicitWidth:  Utils.isMaximize() || Utils.isFullScreen() ? 18 : 13
        implicitHeight: Utils.isMaximize() || Utils.isFullScreen() ? 18 : 13
        radius: implicitWidth / 2
        color: "#f2f2f2"
    }
}
