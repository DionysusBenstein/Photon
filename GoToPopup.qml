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
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 341
    height: 44
    parent: Overlay.overlay
    modal: true
    focus: true
    clip:  true
    padding: 0
    Material.theme: Material.Light
    Material.accent: "#4285f4"

    Rectangle {
        width: 1
        height: 28
        anchors {
            right: parent.right
            rightMargin: 48
            verticalCenter: parent.verticalCenter
        }

        color: "#d9d9d9"
    }
}
