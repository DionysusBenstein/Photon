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
    width: 500; height: 320
    parent: Overlay.overlay
    modal: true
    focus: true
    clip:  true
    padding: 0
    Material.theme: Material.Light
    background: Rectangle {
        color: "#0d0d0d"
        opacity: 0.85
        radius: 2
    }

    ListModel {
        id: referenceModel

        ListElement { description: qsTr("Viewport"); shortcut: "854x480"              }
        //ListElement { description: qsTr("Volume"); shortcut: volumeSlider.value   }
    }

    ListView {
        anchors.fill: parent
        delegate: ItemDelegate {
            id: itemDelegate
            height: 48
            anchors {
                left: parent.left
                right: parent.right
            }

            Text {
                text: description
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 16
                }

                font {
                    pixelSize: 14
                    family: robotoMediumFont.name
                }

                color: "#f1f1f1"
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                text: shortcut
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 16
                }

                font {
                    pixelSize: 14
                    family: robotoMediumFont.name
                }

                color: "#f1f1f1"
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
        }
        model: referenceModel
    }
}


