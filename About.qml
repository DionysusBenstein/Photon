import QtQuick 2.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
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

    Rectangle {
        anchors.fill: parent
        scale: 1.6
        rotation: 147
        gradient: Gradient {
            GradientStop { position: 1.0; color: "#FFE53B" }
            GradientStop { position: 0.0; color: "#FF2525" }
        }
    }

    Rectangle {
        id: aboutWndRect
        width: aboutWndTitle.width + 50
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }

        color: "#0d0d0d"
        opacity: 0.53
        clip: true

        //for material design press animation
        Button {
            anchors.fill: parent
            scale: 1.1
            flat: true
        }
    }

    Text {
        id: aboutWndTitle
        anchors {
            left: parent.left
            top: parent.top
            margins: 25
        }

        color: "white"
        text: qsTr("О программе"/*"About"*/)
        font {
            pixelSize: 20
            family: robotoMediumFont.name
        }
    }

    Text {
        id: appName
        anchors {
            left: parent.left
            top: appLogo.bottom
            leftMargin: 25
            topMargin: 25
        }

        color: "white"
        text: "<b>Photon</b>"
        wrapMode: Text.WordWrap
        font {
            pixelSize: 18
            family: robotoMediumFont.name
        }
    }

    Text {
        id: version
        anchors {
            left: parent.left
            top: appName.bottom
            leftMargin: 25
            topMargin: 5
        }

        color: "white"
        text: qsTr("Версия: " + appVersion)
        wrapMode: Text.WordWrap
        font {
            pixelSize: 16
            family: robotoMediumFont.name
        }
    }

    Text {
        id: author
        anchors {
            left: parent.left
            top: version.bottom
            leftMargin: 25
            topMargin: 5
        }

        color: "white"
        text: "Автор: \nDionysus Benstein"
        wrapMode: Text.WordWrap
        font {
            pixelSize: 16
            family: robotoMediumFont.name
        }
    }

    Text {
        id: about
        anchors {
            left: aboutWndRect.right
            right: parent.right
            top: parent.top
            leftMargin: 19
            rightMargin: 19
            topMargin: 25
        }

        color: "white"
        wrapMode: Text.WordWrap
        text: qsTr("<b>Photon</b> — бесплатный настольный кроссплатформенный медиаплеер
                     и медиа-платформа с открытым исходным кодом, выполненная в стиле YouTube.
                     Photon воспроизводит множество мультимедийных файлов.")

        font {
            pixelSize: 16
            family: robotoMediumFont.name
        }
    }

    MouseArea {
        anchors.fill: copyright
        cursorShape: Qt.PointingHandCursor
    }

    Text {
        id: copyright
        anchors {
            left: aboutWndRect.right
            right: parent.right
            top: about.bottom
            leftMargin: 19
            rightMargin: 19
            topMargin: 25
        }

        text: qsTr("<a href=\"https://github.com/DionysusBenstein\">Copyright © 2018 Dionysus Benstein. Все права защищены.</a>")
        linkColor: "#D22215"
        onLinkActivated: {
            Qt.openUrlExternally("https://github.com/DionysusBenstein")
            popup.close()
        }

        wrapMode: Text.WordWrap
        font {
            pixelSize: 15
            family: robotoMediumFont.name
        }
    }

//    LinearGradient  {
//        anchors.fill: copyright
//        source: copyright
//        start: Qt.point(0, 0)
//        end: Qt.point(200, 200)
//        gradient: Gradient {
//            GradientStop { position: 1.0; color: "#21D4FD" }
//            GradientStop { position: 0.0; color: "#B721FF" }
//        }
//    }

    Image {
        id: appLogo
        anchors {
            top: aboutWndTitle.bottom
            topMargin: 25
            horizontalCenter: aboutWndRect.horizontalCenter
        }

        source: "images/icons/youtube.svg"
        sourceSize.width:  110
        sourceSize.height: 110
    }

    Button {
        id: doneButton
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin:  8
            bottomMargin: 2
        }

        flat: true
        text: qsTr("OK")
        Material.foreground: "white"
        onClicked: popup.close()
    }
}
