/*******************************************************************/

/* Original File Name: Hint.qml                                    */

/* Date: 18-07-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Подсказка с основными горячими клавишами.          */

/*******************************************************************/

import QtQuick 2.11

Item {
    width: 320
    height: 265
    anchors.centerIn: parent
    visible: player.hasVideo ? false : true

    Image {
        id: openIcon
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        fillMode: Image.PreserveAspectFit
        visible: player.hasVideo ? false : true
        source: "images/open-file.png"
    }

    Rectangle {
        id: divider
        height: 1
        width: 300
        anchors {
            top: openIcon.bottom
            horizontalCenter: openIcon.horizontalCenter
            topMargin: 5
        }

        color: "#f1f1f1"
    }

    Text {
        id: openFileText
        anchors {
            left: divider.left
            top: divider.bottom
            topMargin: 10
        }

        text: qsTr("• Открыть файл")
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    Text {
        id: openFileShortcut
        anchors {
            right: divider.right
            top: divider.bottom
            topMargin: 10
        }

        text: "Ctrl + O  "
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    ////////////////////////////////////////////

    Text {
        id: aboutText
        anchors {
            left: divider.left
            top: openFileText.bottom
            topMargin: 5
        }

        text: qsTr("• О программе")
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    Text {
        id: aboutShortcut
        anchors {
            right: divider.right
            top: openFileShortcut.bottom
            topMargin: 5
        }

        text: "Ctrl + A  "
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    ////////////////////////////////////////////

    Text {
        id: referenceText
        anchors {
            left: divider.left
            top: aboutText.bottom
            topMargin: 5
        }

        text: qsTr("• Справка")
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    Text {
        id: referenceShortcut
        anchors {
            right: divider.right
            top: aboutShortcut.bottom
            topMargin: 5
        }

        text: "?  "
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    ////////////////////////////////////////////

    Text {
        id: quitText
        anchors {
            left: divider.left
            top: referenceText.bottom
            topMargin: 5
        }

        text: qsTr("• Выйти")
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    Text {
        id: quitShortcut
        anchors {
            right: divider.right
            top: referenceShortcut.bottom
            topMargin: 5
        }

        text: "Ctrl + Q  "
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }
}
