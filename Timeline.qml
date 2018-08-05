/*******************************************************************/

/* Original File Name: Timeline.qml                                */

/* Date: 18-07-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Слайдер, регулирующий текущее время медиафайла.    */

/*******************************************************************/

import QtQuick 2.11
import "utils.js" as Utils
import QtQuick.Controls 2.4

Slider {
    id: control
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        leftMargin: Utils.isMaximize() || Utils.isFullScreen() ? 18 : 6
        rightMargin: Utils.isMaximize() || Utils.isFullScreen() ? 18 : 6
        bottomMargin: Utils.isMaximize() || Utils.isFullScreen() ? (control.pressed || control.hovered ? 39.5 : 50)
                                                     : (control.pressed || control.hovered ? 25 : 32)
    }

    property int previousX

//    Rectangle {
//        id: hoverRect
//        width: 200
//        anchors {
//            left: background.left
//            top: background.top
//            bottom: background.bottom
//        }

//        color: "#f2f2f2"
//        opacity: 0.63
//    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        enabled: false
//        onPressed: previousX = mouseX
//        onMouseXChanged: {
//            var dx = mouseX - previousX
//            hoverRect.width = hoverRect.width + dx
//        }
    }

    background: Rectangle {
        id: background
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        width: control.availableWidth
        height: Utils.isMaximize() || Utils.isFullScreen() ? (control.pressed || control.hovered ? 8 : 5)
                                               : (control.pressed || control.hovered ? 5 : 3)
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
        color: primaryColor
    }

    handle: Rectangle {
        id: handle
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth:  Utils.isMaximize() || Utils.isFullScreen() ? (control.pressed || control.hovered ? 20 : 0)
                                                       : (control.pressed || control.hovered ? 13 : 0)
        implicitHeight: Utils.isMaximize() || Utils.isFullScreen() ? (control.pressed || control.hovered ? 20 : 0)
                                                       : (control.pressed || control.hovered ? 13 : 0)
        radius: implicitWidth / 2
        color: primaryColor
    }

    onValueChanged: {
        player.seek(player.duration * control.value)
        videoArea.focus = true
    }
}
