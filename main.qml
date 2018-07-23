import QtQuick 2.11
import QtMultimedia 5.9
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 854; height: 480
    title: player.metaData.title + " - " + qsTr("Photon Player v" + appVersion)
    //flags: Qt.FramelessWindowHint | Qt.Window

    property color primaryColor: "#ff0000"
    property color lightColor: "#ff5a36"
    property color darkColor: "#c20000"
    property string appVersion: "0.1.0"
    //property int previousX
    //property int previousY


    function isMaximize() {
        return mainWindow.visibility === ApplicationWindow.Maximized
    }

    function isFullScreen() {
        return mainWindow.visibility === ApplicationWindow.FullScreen
    }

    function msToTime(duration) {
        var seconds = parseInt((duration / 1000) % 60)
        var minutes = parseInt((duration / (1000 * 60)) % 60)
        var hours   = parseInt((duration / (1000 * 60 * 60)) % 60)

        seconds = (seconds < 10) ? "0" + seconds : seconds

        if (hours !==  0) {
            minutes = (minutes < 10) ? "0" + minutes : minutes
            return hours + ":" + minutes + ":" + seconds
        } else {
            return minutes + ":" + seconds
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
        autoPlay: true
        volume: volumeSlider.value
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        source: player
    }

    MouseArea {
        id: videoArea
        anchors.fill: parent
        focus: true

        Keys.onRightPressed: player.seek(player.position + 5000)
        Keys.onLeftPressed: player.seek(player.position - 5000)
        Keys.onSpacePressed: {
            player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
            oButtonBackgroundAnim.running = true
            wButtonBackgroundAnim.running = true
            oButtonIconAnim.running = true
            wButtonIconAnim.running = true
        }

        onDoubleClicked: {
            isMaximize() ? mainWindow.showNormal() : mainWindow.showMaximized()
            isMaximize() || isFullScreen() ? mainWindow.showMaximized() : mainWindow.showFullScreen()
        }

        onReleased: {
            player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
            oButtonBackgroundAnim.running = true
            wButtonBackgroundAnim.running = true
            oButtonIconAnim.running = true
            wButtonIconAnim.running = true
        }

        //onPressed: {
        //    previousX = mouseX
        //   previousY = mouseY
        //}

        //onMouseXChanged: {
        //    var dx = mouseX - previousX
        //    mainWindow.setX(mainWindow.x + dx)
        //}

        //onMouseYChanged: {
        //   var dy = mouseY - previousY
        //    mainWindow.setY(mainWindow.y + dy)
        //}
    }

    Rectangle {
        id: buttonBackground
        width: isMaximize() || isFullScreen() ? 78 : 54
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

    Button {
        y: -6
        text: "Open"
        flat: true
        focus: false
        onClicked: {
            fileDialog.open()
            videoArea.focus = true
        }
    }

    //DEBUG
    //Text {
    //    id: metaDataOutput
    //    anchors {
    //        right: parent.right
    //       top: parent.top
    //        margins: isMaximize() || isFullScreen() ? 18 : 10
    //    }
    //
    //    horizontalAlignment: Text.AlignRight
    //    color: "#f2f2f2"
    //    text: player.metaData.videoFrameRate + "\n"
    //          + player.metaData.videoCodec + "\n"
    //          + player.metaData.audioCodec
    //
    //    font {
    //        family: robotoMediumFont.name
    //        pixelSize: 20
    //    }
    //}

    SeekBar {
        id: seekBar
        value: player.position / player.duration
    }

    VolumeSlider { id: volumeSlider; value: 1 }

    Text {
        anchors {
            left: volumeSlider.right
            bottom: parent.bottom
            leftMargin: 2
            bottomMargin: 11
        }

        color: "#eeeeee"
        text: msToTime(player.position) + " / " + msToTime(player.duration)
        font {
            family: robotoRegularFont.name
            pixelSize: 13
        }
    }

    // play/pause button
    Image {
        id: playButton
        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: isMaximize() || isFullScreen() ? 49 :  29
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
            onClicked: isFullScreen() ? mainWindow.showMaximized() : mainWindow.showFullScreen()
        }
    }

    Settings {
        id: settings
        property alias position: player.position
        property alias duration: player.duration
        property alias source: player.source
    }

    OpacityAnimator {
        id: oButtonBackgroundAnim
        target: buttonBackground
        from: 0.53; to: 0
        duration: 500
        running: false
    }

    OpacityAnimator {
        id: oButtonIconAnim
        target: buttonIcon
        from: 1; to: 0
        duration: 500
        running: false
    }

    ScaleAnimator {
        id: wButtonBackgroundAnim
        target: buttonBackground
        from: 1; to: 2
        duration: 500
        running: false
    }

    ScaleAnimator {
        id: wButtonIconAnim
        target: buttonIcon
        from: 1; to: 2
        duration: 500
        running: false
    }
}
