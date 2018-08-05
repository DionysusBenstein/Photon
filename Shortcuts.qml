/*******************************************************************/

/* Original File Name: Shortcuts.qml                               */

/* Date: 04-08-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Файл для хранения горячих клавиш.                  */

/*******************************************************************/

import QtQuick 2.11
import QtMultimedia 5.9

Item {
    Shortcut {
        sequence: "J"
        onActivated: player.seek(player.position - 10000)
    }

    Shortcut {
        sequence: "L"
        onActivated: player.seek(player.position + 10000)
    }

    Shortcut {
        sequence: "F"
        onActivated: isFullScreen ? mainWindow.showMaximized() : mainWindow.showFullScreen()
    }

    Shortcut {
        sequence: "Home"
        onActivated: seekBar.value = 0
    }

    Shortcut {
        sequence: "End"
        onActivated: seekBar.value = 1
    }

    Shortcut {
        sequence: "Ctrl+A"
        onActivated: aboutWnd.open()
    }

    Shortcut {
        sequence: "Ctrl+F"
        onActivated: feedbackPopup.open()
    }

    Shortcut {
        sequence: "?"
        onActivated: referencePopup.open()
    }

    Shortcut {
        sequence: "M"
        onActivated: volumeSlider.value === 0 ? volumeSlider.value = 1 : volumeSlider.value = 0
    }

    Shortcut {
        sequence: "K"
        onActivated: {
            player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()

            if (player.hasVideo) {
                oButtonBackgroundAnim.running = true
                sButtonBackgroundAnim.running = true
                oButtonIconAnim.running       = true
                sButtonIconAnim.running       = true
            }
        }
    }
}
