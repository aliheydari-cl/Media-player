import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtMultimedia

 Item {
     property var temp

    Item {
        anchors.fill: parent

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: parent.width / 12

            ToolButton {
                id: backButton

                icon.source: "icon/back"
                icon.color: "white"
                icon.width: 20
                icon.height: 20
                onClicked: {
                    timer.restart()

                    if(currentIndex > 0)
                    {
                        currentIndex --

                        temp = playlist.listModel.get(currentIndex).path

                        mediaPlayer.source = playlist.listModel.get(currentIndex).path
                        mediaPlayer.play()
                    }
                }
            }


            ToolButton {
                id: playButton
                icon.source: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "icon/pause.png" : "icon/play.png"
                icon.color: "white"
                onClicked: {
                    timer.restart()

                    if(mediaPlayer.playbackState === MediaPlayer.PlayingState)
                        mediaPlayer.pause()
                    else
                        mediaPlayer.play()
                }
            }

            ToolButton {
                id: nextButton

                icon.source: "icon/next"
                icon.color: "white"
                icon.width: 20
                icon.height: 20
                onClicked: {
                    timer.restart()

                    if(currentIndex < playlist.listModel.rowCount() - 1 && currentIndex != -1)
                    {
                        currentIndex ++

                        temp = playlist.listModel.get(currentIndex).path

                        timer.restart()

                        mediaPlayer.source = playlist.listModel.get(currentIndex).path
                        mediaPlayer.play()
                    }
                }
            }
        }
    }
}
