import QtQuick 2.11
import QtMultimedia 5.9
import QtQuick.Controls 2.4

Slider {
    id: control
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        leftMargin: isMaximize() ? 24 : 12
        rightMargin: isMaximize() ? 24 : 12
        bottomMargin:36 //isMaximize() ? (control.pressed || control.hovered ? 43.5 : 54) : (control.pressed || control.hovered ? 29 : 36)
    }

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        width: control.availableWidth
        height: isMaximize() ? (control.pressed || control.hovered ? 8 : 5) : (control.pressed || control.hovered ? 5 : 3)
        color: "#c2c2c2"

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: primaryColor
        }
    }

    handle: Rectangle {
        id: handle
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        //implicitWidth: isMaximize() ? (control.pressed || control.hovered ? 20 : 0) : (control.pressed || control.hovered ? 13 : 0)
        //implicitHeight: isMaximize() ? (control.pressed || control.hovered ? 20 : 0) : (control.pressed || control.hovered ? 13 : 0)
        radius: implicitWidth / 2
        color: primaryColor
        state: "notHovered"
        states: State {
            name: "notHovered"

            PropertyChanges {
                target: handle
                implicitWidth:  0
                implicitHeight: 0
            }
        }

        State {
            name: "hovered"

            PropertyChanges {
                target: handle
                implicitWidth:  isMaximize() ? 20 : 13
                implicitHeight: isMaximize() ? 20 : 13
            }
        }

        transitions: [
            Transition {
                from: "notHovered"; to: "hovered"

                NumberAnimation {
                    target: handle
                    duration: 100
                }
            },

            Transition {
                from: "hovered"; to: "notHovered"

                NumberAnimation {
                    target: handle
                    duration: 100
                }
            }
        ]
    }
}
