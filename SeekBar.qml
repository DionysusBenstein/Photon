import QtQuick 2.11
import QtMultimedia 5.9
import QtQuick.Controls 2.4

//MouseArea {
//    height: isMaximize() ? 5 : 3
//    anchors {
//        left: parent.left
//        right: parent.right
//        bottom: parent.bottom
//        leftMargin: isMaximize() ? 24 : 12
//        rightMargin: isMaximize() ? 24 : 12
//        bottomMargin: isMaximize() ? 54 : 36
//    }

//    Rectangle {
//        anchors.fill: parent
//        color: primaryColor
//    }
//}

Slider {
    id: control
    value: 0.5

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        leftMargin: isMaximize() ? 24 : 12
        rightMargin: isMaximize() ? 24 : 12
        bottomMargin: isMaximize() ? 54 : 36
    }

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        //implicitWidth: 200
        //implicitHeight: 4
        width: control.availableWidth
        height: isMaximize() ? (control.hovered === true ? 8 : 5) : (control.hovered === true ? 5 : 3)
        color: "#c2c2c2"

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: primaryColor
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: isMaximize() ? (control.hovered === true ? 20 : 0) : (control.hovered === true ? 13 : 0)
        implicitHeight: isMaximize() ? (control.hovered === true ? 20 : 0) : (control.hovered === true ? 13 : 0)
        radius: implicitWidth / 2
        color: primaryColor
    }
}
