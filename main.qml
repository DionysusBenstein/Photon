import QtQuick 2.11
import QtMultimedia 5.9
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.4

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 854; height: 480
    title: qsTr("Photon Player")

    property color primaryColor: "#ff0000"
    property color lightColor: "#ff5a36"
    property color darkColor: "#c20000"

    function isMaximize() {
        return mainWindow.visibility === ApplicationWindow.Maximized
    }

    SeekBar { id: seekBar }

    MediaPlayer {
        id: player
        source: fileDialog.fileUrl
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        source: player

        MouseArea {
            anchors.fill: parent
            onClicked: player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
        }
    }

    FileDialog {
        id: fileDialog
        onAccepted:{
            console.log("You chose: " + fileDialog.fileUrl)
        }
    }
}
