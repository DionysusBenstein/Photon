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

        ListElement { description: qsTr("Шифр Цезаря"); shortcut: "#4285f4"      }
        ListElement { description: qsTr("Шифр Вернама"); shortcut: "#e91e63"     }
        ListElement { description: qsTr("Шифр Виженера"); shortcut: "#f44336"    }
        ListElement { description: qsTr("Шифр Гронсфельда"); shortcut: "#673ab7" }
        ListElement { description: qsTr("Азбука Морзе"); shortcut: "#3f51b5"     }
        ListElement { description: qsTr("Алгоритм Энигмы"); shortcut: "#9c27b0"  }
        ListElement { description: qsTr("Настройки"); shortcut: "#424242"        }
        ListElement { description: qsTr("О программе"); shortcut: "#ff9269"      }
        ListElement { description: qsTr("Выход"); shortcut: "#e81123"            }
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


