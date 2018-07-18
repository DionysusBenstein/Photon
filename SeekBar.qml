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

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        leftMargin: isMaximize() ? 24 : 12
        rightMargin: isMaximize() ? 24 : 12
        bottomMargin: isMaximize() ? 54 : 36
    }

    background: Rectangle {
        //x: control.leftPadding
        //y: control.topPadding + control.availableHeight / 2 - height / 2
        //height: isMaximize() ? 5 : 3
        //color: primaryColor
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: control.availableWidth
        height: isMaximize() ? 5 : 3
        color: primaryColor

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: "#21be2b"
            radius: 2
        }
    }
}
