import QtQuick 2.11
import QtMultimedia 5.9
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.4

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 854; height: 480
    title: qsTr("Photon Player v" + appVersion)

    property string appVersion: "0.1.0"
    property color primaryColor: "#ff0000"
    property color lightColor: "#ff5a36"
    property color darkColor: "#c20000"

    function isMaximize() {
        return mainWindow.visibility === ApplicationWindow.Maximized
    }
    function isFullScreen() {
        return mainWindow.visibility === ApplicationWindow.FullScreen
    }

    FileDialog { id: fileDialog; folder: shortcuts.desktop }

    MediaPlayer {
        id: player
        source: fileDialog.fileUrl
        autoPlay: true
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
        onReleased: player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
        Keys.onSpacePressed: player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
        Keys.onRightPressed: player.seek(player.position + 5000)
        Keys.onLeftPressed: player.seek(player.position - 5000)
        onDoubleClicked: {
            isMaximize() ? mainWindow.showNormal() : mainWindow.showMaximized()
            isMaximize() || isFullScreen() ? mainWindow.showMaximized() : mainWindow.showFullScreen()
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

    SeekBar {
        id: seekBar
        value: player.position / player.duration
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
                isMaximize() || isFullScreen() ? "images/baseline_pause_white_24dp.png" : "images/baseline_pause_white_16dp.png"
            } else {
                isMaximize() || isFullScreen() ? "images/baseline_play_arrow_white_24dp.png" : "images/baseline_play_arrow_white_16dp.png"
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
        }
    }

    //fullscreen
    Image {
        id: fullscreenButton
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: isMaximize() || isFullScreen() ? 49 :  22
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
}
