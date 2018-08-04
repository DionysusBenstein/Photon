import QtQuick 2.11

Item {
    Shortcut {
        sequence: "Home"
        onActivated: seekBar.value = 0
    }

    Shortcut {
        sequence: "End"
        onActivated: seekBar.value = 1
    }

    Shortcut {
        sequence: "F"
        onActivated: isFullScreen() ? mainWindow.showMaximized() : mainWindow.showFullScreen()
    }

    Shortcut {
        sequence: "M"
        onActivated: volumeSlider.value === 0 ? volumeSlider.value = 1 : volumeSlider.value = 0
    }

    Shortcut {
        sequence: "J"
        onActivated: player.seek(player.position - 10000)
    }

    Shortcut {
        sequence: "L"
        onActivated: player.seek(player.position + 10000)
    }

    Shortcut {
        sequence: "Ctrl+A"
        onActivated: aboutWnd.open()
    }

    Shortcut {
        sequence: "?"
        onActivated: referenceWnd.open()
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
