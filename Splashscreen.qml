/*******************************************************************/

/* Original File Name: Splashscreen.qml                            */

/* Date: 05-08-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Заставка во время инициализации програмы.          */

/*******************************************************************/

import QtQuick 2.11

Item {
    id: root
    anchors.fill: parent

    property bool appIsReady: false
    property bool splashIsReady: false
    property bool ready: appIsReady && splashIsReady

    onReadyChanged: if (ready) readyToGo();

    signal readyToGo()

    Rectangle {
        width: 426
        height: 320
        anchors.centerIn: parent
        color: "red"
    }

    Timer {
        id: splashTimer
        interval: 1000
        onTriggered: splashIsReady = true
    }

    Component.onCompleted: splashTimer.start()
}
