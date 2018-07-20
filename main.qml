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

    FileDialog { id: fileDialog }

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
        anchors.fill: parent
        onClicked: player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
    }

    ToolBar {
        id: toolBar
        ToolButton {
            text: "Open"
            onPressed: fileDialog.open()
        }
    }

    SeekBar {
        id: seekBar
        value: player.position / player.duration
    }
}
