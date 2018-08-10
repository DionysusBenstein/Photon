/*******************************************************************/

/* Original File Name: Splashscreen.qml                            */

/* Date: 05-08-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Заставка во время инициализации програмы.          */

/*******************************************************************/

import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Loader {
    id: loader

    Component {
        id: splash

        Window {
            id: splashWindow
            x: Math.round((mainWindow.width - width) / 2)
            y: Math.round((mainWindow.height - height) / 2)
            width: 300
            height: 200
            modality: Qt.ApplicationModal
            flags: Qt.SplashScreen
            color: "#DEDEDE"

            signal timeout()

            ProgressBar {
                id: progress
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                value: 0
                to: 100
                from: 0
            }

            Timer {
                id: timer
                interval: 50
                running: true
                repeat: true
                onTriggered: {
                    progress.value++;

                    if(progress.value >= 100) {
                        timer.stop();
                        splashWindow.timeout();
                    }
                }
            }
        }
    }

    Component {
        id: root

        Window {
            id: rootWindow
            width: 800
            height: 600
        }
    }

    sourceComponent: splash
    active: true
    visible: true
    onStatusChanged: {
        if (loader.status === Loader.Ready) {
            item.show();
        }
    }

    Connections {
        id: connection
        target: loader.item
        onTimeout: {
            connection.target = null;
            loader.sourceComponent = root;
        }
    }
}
