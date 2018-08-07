/*******************************************************************/

/* Original File Name: GoToPopup.qml                               */

/* Date: 04-08-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Всплывающее окно для перехода по таймингу.         */

/*******************************************************************/

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3

Popup {
    id: popup
    //x: Math.round((parent.width - width) / 2)
    //y: Math.round((parent.height - height) / 2)
    x: isMaximize || isFullScreen ? 24 : 16
    y: isMaximize || isFullScreen ? 24 : 16
    width: 341; height: 45
    parent: Overlay.overlay
    modal: true
    focus: true
    clip:  true
    padding: 0
    Material.theme: Material.Light
    Material.accent: "#4285f4"

    //Close
    ToolButton {
        id: closeButton
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        onClicked: close()
    }

    Item {
        anchors.centerIn: closeButton
        width: 24; height: 24

        Rectangle {
            width: 2; height: 13
            anchors.centerIn: parent
            antialiasing: true
            color: "#4c4c4c"
            rotation: 45
            radius: 2
        }

        Rectangle {
            width: 2; height: 13
            anchors.centerIn: parent
            antialiasing: true
            color: "#4c4c4c"
            rotation: 135
            radius: 2
        }
    }

    //Done
    ToolButton {
        id: doneButton
        anchors {
            left: divider.right
            verticalCenter: parent.verticalCenter
        }
        onClicked: close()
    }

    Image {
        anchors.centerIn: doneButton
        source: "images/baseline_done_black_18dp.png"
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: divider
        width: 1
        height: 28
        anchors {
            right: parent.right
            rightMargin: 48 + 32
            verticalCenter: parent.verticalCenter
        }

        color: "#d9d9d9"
    }

    TextField {
        anchors {
            left: parent.left
            right: divider.left
            top: parent.top
            leftMargin: 16
            rightMargin: 16
            topMargin: 5
        }

        placeholderText: "Введите тайминг"
        background: Rectangle {
            color: "white"
        }

    }
}
