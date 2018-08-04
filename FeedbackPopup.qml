/*******************************************************************/

/* Original File Name: Reference.qml                               */

/* Date: 04-08-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Всплывающее меню с информацие о хоткеях.           */

/*******************************************************************/

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3

Popup {
    id: popup
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 360; height: 400
    parent: Overlay.overlay
    modal: true
    focus: true
    clip:  true
    padding: 0
    Material.theme: Material.Light

    ToolBar {
        id: appBar
        height: 56
        anchors {
            left: parent.left
            right: parent.right
        }

        Rectangle {
            id: appBarRect
            anchors.fill: parent
            color: "#4285f4"

            Text {
                id: headerText
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    margins: 19
                }

                text: "Отправить отзыв"
                color: "white"
                font {
                    family: robotoMediumFont.name
                    pointSize: 15
                }
            }
        }
    }

    Button {
        id: doneButton
        anchors {
            right: parent.right
            bottom: parent.bottom
            bottomMargin: 2
            rightMargin: 8
        }

        text: qsTr("Отправить")
        Material.foreground: "#4285f4"
        flat: true
        onClicked: popup.close()
    }

    Button {
        id: cancelButton
        anchors {
            right: doneButton.left
            bottom: parent.bottom
            rightMargin: 8
            bottomMargin: 2
        }

        text: qsTr("Отмена")
        Material.foreground: "#757575"
        flat: true
        onClicked: popup.close()
    }
}


