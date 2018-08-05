/*******************************************************************/

/* Original File Name: FeedbackPopup.qml                           */

/* Date: 04-08-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Всплывающее окно для отправки отзывов.             */

/*******************************************************************/

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3

Popup {
    id: popup
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 360
    height: cbScreenshot.checked ? minToMax.running = true : maxToMin.running = true
    parent: Overlay.overlay
    modal: true
    focus: true
    clip:  true
    padding: 0
    Material.theme: Material.Light
    Material.accent: "#4285f4"

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
                    margins: 16
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

    TextArea {
        id: feedbackMessage
        height: 128
        anchors {
            left: parent.left
            right: parent.right
            top: appBar.bottom
            margins: 16
        }

        placeholderText: "Опишите проблему или поделитель \nмнением"
        wrapMode: Text.WordWrap
        selectByMouse: true
        persistentSelection: true

        MouseArea {
            id: inputMouseArea
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            cursorShape: Qt.IBeamCursor
            onClicked: contextMenu.popup()
        }

        Menu {
            id: contextMenu
            MenuItem { text: qsTr("Вырезать"/*"Cut"*/); enabled: feedbackMessage.selectedText; onTriggered: feedbackMessage.cut()     }
            MenuItem { text: qsTr("Копировать"/*"Copy"*/); enabled: feedbackMessage.selectedText; onTriggered: feedbackMessage.copy() }
            MenuItem { text: qsTr("Вставить"/*"Paste"*/); enabled: feedbackMessage.canPaste; onTriggered: feedbackMessage.paste()     }
        }
    }

    CheckBox {
        id: cbScreenshot
        anchors {
            left: parent.left
            top: feedbackMessage.bottom
            leftMargin: 8
        }

        text: qsTr(" Прикрепить скриншот")
        checked: true
    }

    Rectangle {
        id: screenshotRect
        height: 165
        anchors {
            left: parent.left
            right: parent.right
            top: cbScreenshot.bottom
            bottom: parent.bottom
            bottomMargin: 52
        }

        color: "#eeeeee"

        Image {
            id: screenshot
            anchors.fill: parent
            source: "file:///C:/Users/Денис/Desktop/Безымянный.png"
            fillMode: Image.PreserveAspectFit
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

    NumberAnimation {
        id: maxToMin
        target: popup
        property: "height"
        from: 480; to: 300
        duration: 200
        running: false
        easing.type: Easing.InOutQuad
    }

    NumberAnimation {
        id: minToMax
        target: popup
        property: "height"
        from: 300; to: 480
        duration: 200
        running: false
        easing.type: Easing.InOutQuad
    }
}
