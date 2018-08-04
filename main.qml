/*******************************************************************/

/* Original File Name: main.qml                                    */

/* Date: 18-07-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Основное окно программы.                           */

/*******************************************************************/

import QtQuick 2.11
import QtMultimedia 5.9
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0
import QtQuick.Controls.Material 2.3

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 854; height: 480
    title: qsTr("Photon Player v" + appVersion)

    readonly property color lightFontColor: "#9a9a9a"
    readonly property color darkFontColor: "#404040"
    readonly property color primaryColor: "#ff0000"
    readonly property color lightColor: "#ff5a36"
    readonly property color darkColor: "#c20000"
    property string appVersion: "0.1.0"

    function isMaximize() {
        return mainWindow.visibility === ApplicationWindow.Maximized;
    }

    function isFullScreen() {
        return mainWindow.visibility === ApplicationWindow.FullScreen;
    }

    function msToTime(duration) {
        var seconds = parseInt((duration / 1000) % 60);
        var minutes = parseInt((duration / (1000 * 60)) % 60);
        var hours   = parseInt((duration / (1000 * 60 * 60)) % 60);

        seconds = (seconds < 10) ? "0" + seconds : seconds;

        if (hours !==  0) {
            minutes = (minutes < 10) ? "0" + minutes : minutes;
            return hours + ":" + minutes + ":" + seconds;
        } else {
            return minutes + ":" + seconds;
        }
    }

    FontLoader { id: robotoThinFont; source: "fonts/Roboto-Thin_0.ttf"       }
    FontLoader { id: robotoLightFont; source: "fonts/Roboto-Light.ttf"       }
    FontLoader { id: robotoMediumFont; source: "fonts/Roboto-Medium.ttf"     }
    FontLoader { id: robotoRegularFont; source: "fonts/Roboto-Regular_0.ttf" }

    FileDialog {
        id: fileDialog
        folder: shortcuts.desktop
        nameFilters: [ "Медиафайлы ( *.ogg *.mpg *.wav *.mp3 *.mp4 *.avi *.mkv *.mov )", "Все файлы (*)" ]
    }

    MediaPlayer {
        id: player
        source: fileDialog.fileUrl
        volume: volumeSlider.value
        audioRole: MediaPlayer.VideoRole
        autoPlay: true
    }

    //Hint
    Image {
        id: openIcon
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin: 100
        }

        source: "images/open-file.png"
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: divider
        height: 1
        width: 300
        anchors {
            top: openIcon.bottom
            horizontalCenter: openIcon.horizontalCenter
            topMargin: 5
        }

        color: "#f1f1f1"
    }

    Text {
        id: openFileText
        anchors {
            left: divider.left
            top: divider.bottom
            topMargin: 10
        }

        text: "• Открыть файл"
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    Text {
        id: openFileShortcut
        anchors {
            right: divider.right
            top: divider.bottom
            topMargin: 10
        }

        text: "Ctrl + O  "
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    ////////////////////////////////////////////

    Text {
        id: aboutText
        anchors {
            left: divider.left
            top: openFileText.bottom
            topMargin: 5
        }

        text: "• О программе"
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    Text {
        id: aboutShortcut
        anchors {
            right: divider.right
            top: openFileShortcut.bottom
            topMargin: 5
        }

        text: "Ctrl + A  "
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    ////////////////////////////////////////////

    Text {
        id: referenceText
        anchors {
            left: divider.left
            top: aboutText.bottom
            topMargin: 5
        }

        text: "• Справка"
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    Text {
        id: referenceShortcut
        anchors {
            right: divider.right
            top: aboutShortcut.bottom
            topMargin: 5
        }

        text: "?  "
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    ////////////////////////////////////////////

    Text {
        id: quitText
        anchors {
            left: divider.left
            top: referenceText.bottom
            topMargin: 5
        }

        text: "• Выйти"
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }

    Text {
        id: quitShortcut
        anchors {
            right: divider.right
            top: referenceShortcut.bottom
            topMargin: 5
        }

        text: "Ctrl + Q  "
        color: "#f1f1f1"
        font {
            family: robotoMediumFont.name
            pixelSize: 20
        }
    }
    //Hint end

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        source: player
    }

    MouseArea {
        id: videoArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: videoArea.state = "active ui"
        onExited: videoArea.state = "inactive ui"
        focus: true
        opacity: 0
        state: player.playbackState === MediaPlayer.PausedState ? "active ui" : "inactive ui"
        states: [
            State {
                name: "active ui"
                PropertyChanges { target: videoArea; opacity: 1 }
            },

            State {
                name: "inactive ui"
                PropertyChanges { target: videoArea; opacity: 0 }
            }
        ]

        transitions: [
            Transition {
                from: "inactive ui"; to: "active ui"
                OpacityAnimator { duration: 100 }
            },

            Transition {
                from: "active ui"; to: "inactive ui"
                OpacityAnimator { duration: 100 }
            }
        ]

        Keys.onRightPressed: player.seek(player.position + 5000)
        Keys.onLeftPressed:  player.seek(player.position - 5000)
        Keys.onUpPressed: player.volume + 0.05
        Keys.onDownPressed: player.volume - 0.05
        Keys.onSpacePressed: {
            player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()

            if (player.hasVideo) {
                oButtonBackgroundAnim.running = true
                sButtonBackgroundAnim.running = true
                oButtonIconAnim.running       = true
                sButtonIconAnim.running       = true
            }
        }

        onDoubleClicked: {
            isMaximize() ? mainWindow.showNormal() : mainWindow.showMaximized()
            isMaximize() || isFullScreen() ? mainWindow.showMaximized() : mainWindow.showFullScreen()
        }

        onReleased: {
            player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()

            if (player.hasVideo) {
                oButtonBackgroundAnim.running = true
                sButtonBackgroundAnim.running = true
                oButtonIconAnim.running       = true
                sButtonIconAnim.running       = true
            }
        }

        Rectangle {
            id: buttonBackground
            width:  isMaximize() || isFullScreen() ? 78 : 54
            height: isMaximize() || isFullScreen() ? 78 : 54
            anchors.centerIn: parent
            radius: width / 2
            color: "#0d0d0d"
            //opacity: 0.53
            opacity: 0
        }

        Image {
            id: buttonIcon
            anchors.centerIn: buttonBackground
            opacity: 0
            source: {
                if (player.playbackState === MediaPlayer.PlayingState) {
                    isMaximize() || isFullScreen() ? "images/baseline_play_arrow_white_24dp.png"
                                                   : "images/baseline_play_arrow_white_16dp.png"
                } else {
                    isMaximize() || isFullScreen() ? "images/baseline_pause_white_24dp.png"
                                                   : "images/baseline_pause_white_16dp.png"
                }
            }
        }

        Rectangle {
            id: topShadow
            width: parent.width
            height: isMaximize() || isFullScreen() ? 109 : 76
            anchors.top: parent.top
            opacity: 0.66
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#000000"     }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        Rectangle {
            id: bottomShadow
            width: parent.width
            height: isMaximize() || isFullScreen() ? 109 : 76
            anchors.bottom: parent.bottom
            opacity: 0.66
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: "#000000"     }
            }
        }

        ToolButton {
            anchors {
                right: parent.right
                top: parent.top
            }

            flat:  true
            focus: false
            icon.source: "images/more_vert-24dp.png"
            onClicked: moreButtonMenu.open()

            Menu {
                id: moreButtonMenu
                Material.theme: Material.Dark

                MenuItem {
                    text: qsTr("Открыть файл...")
                    onTriggered: {
                        fileDialog.open()
                        videoArea.focus = true
                    }

                    Shortcut {
                        sequence: "Ctrl+O"
                        onActivated: {
                            fileDialog.open()
                            videoArea.focus = true
                        }
                    }
                }

                MenuItem {
                    text: qsTr("О программе...")
                    onTriggered: {
                        aboutWnd.open()
                    }
                }

                MenuItem {
                    text: qsTr("Справка")
                    onTriggered: {
                        referenceWnd.open()
                    }
                }

                MenuItem {
                    text: qsTr("Выход")
                    onTriggered: Qt.quit()

                    Shortcut {
                        sequence: "Ctrl+Q"
                        onActivated: Qt.quit()
                    }
                }
            }
        }

        SeekBar { id: seekBar; value: player.position / player.duration }
        VolumeSlider { id: volumeSlider; value: 1 }

        Text {
            anchors {
                left: volumeSlider.right
                bottom: parent.bottom
                leftMargin:   isMaximize() || isFullScreen() ? 4 : 2
                bottomMargin: isMaximize() || isFullScreen() ? 16 : 11
            }

            color: "#eeeeee"
            text: "<b>" + msToTime(player.position) + "</b>" + " / " + msToTime(player.duration)
            font {
                family: robotoRegularFont.name
                pixelSize: isMaximize() || isFullScreen() ? 18 : 13
            }
        }

        Text {
            id: title
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: isMaximize() || isFullScreen() ? 19 : 16
                topMargin: isMaximize() || isFullScreen() ? 21 : 12
            }

            color: "#eeeeee"
            text: player.metaData.title ? player.metaData.title : "Media file title unavailable"
            font {
                family: robotoRegularFont.name
                pixelSize: isMaximize() || isFullScreen() ? 26 : 18
            }
        }

        // play/pause button
        Image {
            id: playButton
            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin:  isMaximize() || isFullScreen() ? 49 :  29
                bottomMargin: isMaximize() || isFullScreen() ? 15 : 10
            }

            source: {
                if (player.playbackState === MediaPlayer.PlayingState) {
                    isMaximize() || isFullScreen() ? "images/baseline_pause_white_24dp.png"
                                                   : "images/baseline_pause_white_16dp.png"
                } else {
                    isMaximize() || isFullScreen() ? "images/baseline_play_arrow_white_24dp.png"
                                                   : "images/baseline_play_arrow_white_16dp.png"
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
            }
        }

        // fullscreen
        Image {
            id: fullscreenButton
            anchors {
                right: parent.right
                bottom: parent.bottom
                rightMargin: isMaximize() || isFullScreen() ? 39 : 22
                bottomMargin: isMaximize() || isFullScreen() ? 15 : 10
            }

            source: {
                if (isFullScreen()) {
                    "images/baseline-fullscreen_exit-white-24dp.png"
                } else if (isMaximize()) {
                    "images/baseline-fullscreen-white-24dp.png"
                } else {
                    "images/baseline-fullscreen-white-16dp.png"
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onPressed: isFullScreen() ? mainWindow.showMaximized() : mainWindow.showFullScreen()
            }
        }
    }

    About { id: aboutWnd }
    Reference { id: referenceWnd }
    Shortcuts { }

    //Settings {
    //    id: settings
    //    property alias position: player.position
    //    property alias duration: player.duration
    //    property alias source: player.source
    //}

    OpacityAnimator {
        id: oButtonBackgroundAnim
        target: buttonBackground
        from: 0.53; to: 0
        running: false
        duration: 500
    }

    OpacityAnimator {
        id: oButtonIconAnim
        target: buttonIcon
        from: 1; to: 0
        running: false
        duration: 500
    }

    ScaleAnimator {
        id: sButtonBackgroundAnim
        target: buttonBackground
        from: 1; to: 2
        running: false
        duration: 500
    }

    ScaleAnimator {
        id: sButtonIconAnim
        target: buttonIcon
        from: 1; to: 2
        running: false
        duration: 500
    }
}
