import QtQuick 2.11
import QtMultimedia 5.9
import QtQuick.Controls 2.4

Rectangle {
    height: isMaximize() ? 5 : 3
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        leftMargin: isMaximize() ? 24 : 12
        rightMargin: isMaximize() ? 24 : 12
        bottomMargin: isMaximize() ? 54 : 36
    }

    color: primaryColor
}
