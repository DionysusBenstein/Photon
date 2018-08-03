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

    ListModel {
        id: referenceModel

        ListElement { name: qsTr("Шифр Цезаря"); iconColor: "#4285f4"      }
        ListElement { name: qsTr("Шифр Вернама"); iconColor: "#e91e63"     }
        ListElement { name: qsTr("Шифр Виженера"); iconColor: "#f44336"    }
        ListElement { name: qsTr("Шифр Гронсфельда"); iconColor: "#673ab7" }
        ListElement { name: qsTr("Азбука Морзе"); iconColor: "#3f51b5"     }
        ListElement { name: qsTr("Алгоритм Энигмы"); iconColor: "#9c27b0"  }
        ListElement { name: qsTr("Настройки"); iconColor: "#424242"        }
        ListElement { name: qsTr("О программе"); iconColor: "#ff9269"      }
        ListElement { name: qsTr("Выход"); iconColor: "#e81123"            }
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
                text: name
                anchors {
                    fill: parent
                    left: itemIcon.right
                    leftMargin: 72
                }

                font.family: robotoRegularFont.name
                font.pixelSize: 14

                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle {
                id: itemIcon
                width: 18
                height: 18
                color: iconColor
                radius: 9
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 16
                }
            }

            onClicked: {
                loader.loadFragment(index)
                nav.close()
            }
        }
        model: referenceModel
    }
}


