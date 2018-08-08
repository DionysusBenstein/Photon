/*******************************************************************/

/* Original File Name: GoToPopup.qml                               */

/* Date: 04-08-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Всплывающее окно для перехода по таймингу.         */

/*******************************************************************/

import QtQuick 2.11
import QtQuick.Controls 2.4
import "utils.js" as Utils
import QtQuick.Controls.Material 2.3

Popup {
    id: popup
    x: isMaximize || isFullScreen ? 24 : 16
    y: isMaximize || isFullScreen ? 24 : 16
    width: 246; height: 45
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
            width: 1.5; height: 13
            anchors.centerIn: parent
            antialiasing: true
            color: "#4c4c4c"
            rotation: 45
            radius: 2
        }

        Rectangle {
            width: 1.5; height: 13
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

        onClicked: {
            if(player.hasAudio || player.hasAudio) {
                console.log(input.text)
                player.seek(Utils.timeToMs(0, 0, 20))
            }
            close()
        }
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
            rightMargin: 48 + 36
            verticalCenter: parent.verticalCenter
        }
        color: "#d9d9d9"
    }

    TextField {
        id: input
        anchors {
            left: parent.left
            right: divider.left
            top: parent.top
            leftMargin: 16
            rightMargin: 16
            topMargin: 5
        }

        focus: true
        selectByMouse: true
        persistentSelection: true
        placeholderText: qsTr("Введите тайминг"/*"Enter timing"*/)
        background: Rectangle { color: "white" }
        validator: RegExpValidator { regExp:  /^[0-5]?[0-9]:[0-5]?[0-9]:[0-5][0-9]$/ }

        MouseArea {
            id: inputMouseArea
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            cursorShape: Qt.IBeamCursor
            onClicked: contextMenu.popup()
        }

        Menu {
            id: contextMenu
            MenuItem { text: qsTr("Вырезать"/*"Cut"*/); enabled: input.selectedText; onTriggered: input.cut()     }
            MenuItem { text: qsTr("Копировать"/*"Copy"*/); enabled: input.selectedText; onTriggered: input.copy() }
            MenuItem { text: qsTr("Вставить"/*"Paste"*/); enabled: input.canPaste; onTriggered: input.paste()     }
        }
    }
}
