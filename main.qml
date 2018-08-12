/*******************************************************************/

/* Original File Name: main.qml                                    */

/* Date: 18-07-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Основное окно программы.                           */

/*******************************************************************/

import QtQuick 2.11
import QtMultimedia 5.9
import "utils.js" as Utils
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.3

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 854; height: 480
    title: qsTr("Photon Player v" + appVersion)

    readonly property bool isFullScreen: mainWindow.visibility === ApplicationWindow.FullScreen
    readonly property bool isMaximize: mainWindow.visibility === ApplicationWindow.Maximized
    readonly property color lightFontColor: "#9a9a9a"
    readonly property color darkFontColor: "#404040"
    readonly property color primaryColor: "#ff0000"
    readonly property color lightColor: "#ff5a36"
    readonly property color darkColor: "#c20000"
    readonly property string appVersion: "0.1.0"

    FontLoader { id: robotoThinFont; source: "fonts/Roboto-Thin_0.ttf"       }
    FontLoader { id: robotoLightFont; source: "fonts/Roboto-Light.ttf"       }
    FontLoader { id: robotoMediumFont; source: "fonts/Roboto-Medium.ttf"     }
    FontLoader { id: robotoRegularFont; source: "fonts/Roboto-Regular_0.ttf" }

    FileDialog {
        id: fileDialog
        folder: shortcuts.desktop
        nameFilters: [ qsTr("Медиафайлы") + " ( *.ogg *.mpg *.wav *.mp3 *.mp4 *.avi *.mkv *.mov )", qsTr("Все файлы") + " (*)" ]
    }

    MediaPlayer {
        id: player
        source: fileDialog.fileUrl
        volume: volumeSlider.value
        audioRole: MediaPlayer.VideoRole
        autoPlay: true
        loops: contextMenu.isLoops ? MediaPlayer.Infinite : 0
    }

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
        propagateComposedEvents: true
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

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onMouseXChanged: videoArea.state = "active ui"
        onMouseYChanged: videoArea.state = "active ui"
        onClicked: if (mouse.button === Qt.RightButton) contextMenu.popup()
        Keys.onEscapePressed: if (isFullScreen) mainWindow.showNormal()
        Keys.onRightPressed: if(player.hasAudio || player.hasAudio) player.seek(player.position + 5000)
        Keys.onLeftPressed: if(player.hasAudio || player.hasAudio) player.seek(player.position - 5000)
        Keys.onUpPressed: {
            volumeSlider.value += 0.05
            //oButtonBackgroundAnim.running = true;
            //sButtonBackgroundAnim.running = true;
            //oButtonIconAnim.running       = true;
            //sButtonIconAnim.running       = true;
        }

        Keys.onDownPressed: {
            volumeSlider.value -= 0.05
            //oButtonBackgroundAnim.running = true;
            //sButtonBackgroundAnim.running = true;
            //oButtonIconAnim.running       = true;
            //sButtonIconAnim.running       = true;
        }

        Keys.onSpacePressed: {
            if (player.hasVideo || player.hasAudio) {
                player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
                oButtonBackgroundAnim.running = true;
                sButtonBackgroundAnim.running = true;
                oButtonIconAnim.running       = true;
                sButtonIconAnim.running       = true;
            }
        }

        onDoubleClicked: {
            isMaximize ? mainWindow.showNormal() : mainWindow.showMaximized()
            isMaximize || isFullScreen ? mainWindow.showMaximized() : mainWindow.showFullScreen()
        }

        onPressed: {
            if (player.hasVideo && mouse.button === Qt.LeftButton) {
                player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
                oButtonBackgroundAnim.running = true;
                sButtonBackgroundAnim.running = true;
                oButtonIconAnim.running       = true;
                sButtonIconAnim.running       = true;
            }
        }

        Rectangle {
            id: buttonBackground
            width:  isMaximize || isFullScreen ? 78 : 54
            height: isMaximize || isFullScreen ? 78 : 54
            anchors.centerIn: parent
            radius: width / 2
            color: "#0d0d0d"
            //opacity: 0.53
            opacity: 0
        }

        //Play/Pause animation
        Image {
            id: buttonIcon
            anchors.centerIn: buttonBackground
            opacity: 0
            source: {
                if (player.playbackState === MediaPlayer.PlayingState) {
                    isMaximize || isFullScreen ? "images/baseline_play_arrow_white_24dp.png"
                                               : "images/baseline_play_arrow_white_16dp.png"
                } else {
                    isMaximize || isFullScreen ? "images/baseline_pause_white_24dp.png"
                                               : "images/baseline_pause_white_16dp.png"
                }
            }
        }

        Rectangle {
            id: topShadow
            width: parent.width
            height: isMaximize || isFullScreen ? 109 : 76
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
            height: isMaximize || isFullScreen ? 109 : 76
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
                        referencePopup.open()
                    }
                }

                MenuItem {
                    text: qsTr("Выход")
                    onTriggered: Qt.quit()
                }
            }
        }

        Timeline { id: seekBar; value: player.position / player.duration }
        VolumeSlider { id: volumeSlider; value: 1 }

        Image {
            id: volumeIcon
            anchors {
                left: playButton.right
                bottom: parent.bottom
                leftMargin:   isMaximize || isFullScreen ? 30 : 21
                bottomMargin: isMaximize || isFullScreen ? 12 : 6
            }

            source: {
                if (volumeSlider.value <= 0.5 && volumeSlider.value > 0) {
                    "images/baseline-volume_down-24px.svg";
                } else if (volumeSlider.value === 0) {
                    "images/baseline-volume_off-24px.svg";
                } else {
                    "images/baseline-volume_up-24px.svg";
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onPressed: volumeSlider.value === 0 ? volumeSlider.value = 1 : volumeSlider.value = 0
            }
        }

        ColorOverlay {
            anchors.fill: volumeIcon
            source: volumeIcon
            color: "#edeeef"
        }

        Text {
            id: time
            anchors {
                left: volumeSlider.right
                bottom: parent.bottom
                leftMargin:   isMaximize || isFullScreen ? 4 : 2
                bottomMargin: isMaximize || isFullScreen ? 16 : 11
            }

            color: "#eeeeee"

            text: "<b>" + Utils.msToTime(player.position) + "</b>" + " / " + Utils.msToTime(player.duration)
            font {
                family: robotoRegularFont.name
                pixelSize: isMaximize || isFullScreen ? 18 : 13
            }
        }

        Text {
            id: title
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: isMaximize || isFullScreen ? 19 : 16
                topMargin: isMaximize || isFullScreen ? 21 : 12
            }

            color: "#eeeeee"
            text: player.metaData.title ? player.metaData.title : ""
            font {
                family: robotoRegularFont.name
                pixelSize: isMaximize ||isFullScreen ? 26 : 18
            }
        }

        //Play/Pause button
        Image {
            id: playButton
            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin:  isMaximize || isFullScreen ? 49 :  29
                bottomMargin: isMaximize || isFullScreen ? 15 : 10
            }

            source: {
                if (player.playbackState === MediaPlayer.PlayingState) {
                    isMaximize || isFullScreen ? "images/baseline_pause_white_24dp.png"
                                               : "images/baseline_pause_white_16dp.png";
                } else {
                    isMaximize || isFullScreen ? "images/baseline_play_arrow_white_24dp.png"
                                               : "images/baseline_play_arrow_white_16dp.png";
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
            }
        }

        //Fullscreen
        Image {
            id: fullscreenButton
            anchors {
                right: parent.right
                bottom: parent.bottom
                rightMargin: isMaximize || isFullScreen ? 39 : 22
                bottomMargin: isMaximize || isFullScreen ? 15 : 10
            }

            source: {
                if (isFullScreen) {
                    "images/baseline-fullscreen_exit-white-24dp.png";
                } else if (isMaximize) {
                    "images/baseline-fullscreen-white-24dp.png";
                } else {
                    "images/baseline-fullscreen-white-16dp.png";
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onPressed: isFullScreen ? mainWindow.showMaximized() : mainWindow.showFullScreen()
            }
        }
    }

    //StatisticsPopup { id: satisticsPopup }
    ReferencePopup { id: referencePopup }
    FeedbackPopup { id: feedbackPopup }
    //Splashscreen { id: splashscreen }
    ContextMenu { id: contextMenu }
    AboutPopup { id: aboutWnd }
    Shortcuts { id: totalShortcuts }
    GoToPopup { id: goToPopup }
    Hint { id: hint }

    Settings {
        id: settings
        property alias repeatSwitchChecked: contextMenu.repeatSwitchChecked
        //property alias videoSource: player.source
        //property alias position: player.position
    }

    Timer {
        interval: 4000
        running: false
        onTriggered: videoArea.state = "inactive ui"
    }

    OpacityAnimator {
        id: oButtonBackgroundAnim
        target: buttonBackground
        alwaysRunToEnd: false
        from: 0.53; to: 0
        running: false
        duration: 500
    }

    OpacityAnimator {
        id: oButtonIconAnim
        target: buttonIcon
        alwaysRunToEnd: false
        from: 1; to: 0
        running: false
        duration: 500
    }

    ScaleAnimator {
        id: sButtonBackgroundAnim
        target: buttonBackground
        alwaysRunToEnd: false
        from: 1; to: 2
        running: false
        duration: 500
    }

    ScaleAnimator {
        id: sButtonIconAnim
        target: buttonIcon
        alwaysRunToEnd: false
        from: 1; to: 2
        running: false
        duration: 500
    }
}
