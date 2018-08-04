import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3

Popup {
    id: popup
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 426; height: 320
    parent: Overlay.overlay
    modal: true
    focus: true
    clip:  true
    padding: 0
    background: Rectangle {
        color: "#0d0d0d"
        opacity: 0.85
        radius: 2
    }

    ListModel {
        id: referenceModel

        ListElement { description: qsTr("Перемотать ролик на 10 секунд назад"); shortcut: "j"              }
        ListElement { description: qsTr("Перемотать ролик на 10 секунд вперед"); shortcut: "l"             }
        ListElement { description: qsTr("Включить или отключить звук"); shortcut: "m"                      }
        ListElement { description: qsTr("Приостановить или продолжить воспроизведение"); shortcut: "k"     }
        ListElement { description: qsTr("Включить или выключить полноэкранный режим"); shortcut: "f"       }
        ListElement { description: qsTr("Перемотать ролик на 5 секунд назад"); shortcut: "Стрелка влево"   }
        ListElement { description: qsTr("Перемотать ролик на 5 секунд вперед"); shortcut: "Стрелка вправо" }
        ListElement { description: qsTr("Увеличить громкость на 5%"); shortcut: "Стрелка вверх"            }
        ListElement { description: qsTr("Уменьшить громкость на 5%"); shortcut: "Стрелка вниз"             }
        ListElement { description: qsTr("Закрыть диалоговое оконо"); shortcut: "Esc"                       }
        ListElement { description: qsTr("Перейти к началу ролика"); shortcut: "Home"                       }
        ListElement { description: qsTr("Перейти к концу видео"); shortcut: "End"                          }
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


