/*******************************************************************/

/* Original File Name: ContextMenu.qml                             */

/* Date: 04-08-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Контекстное меню для управления воспроизведением.  */

/*******************************************************************/

import QtQuick 2.11
import QtQuick.Controls 2.4

Menu {
    id: contextMenu
    width: 325

    property alias isLoops: repeatSwitch.checked

    MenuItem {
        text: qsTr("Повтор")
        Switch { id: repeatSwitch; anchors.right: parent.right }
        onTriggered: repeatSwitch.toggle()
    }

//    MenuItem {
//        text: qsTr("Решить проблему с воспроизведением")
//    }

    MenuItem {
        text: qsTr("Статистика для разработчиков")
    }
}

