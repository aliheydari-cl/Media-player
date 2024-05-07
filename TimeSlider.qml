import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtMultimedia

Item {

    function formatTime(millis) {
        var totalSeconds = Math.floor(millis / 1000);
        var minutes = Math.floor(totalSeconds / 60);
        var seconds = totalSeconds % 60;

        return (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds);
    }

    Row {
        width: parent.width
        height: parent.height

        Label {
            id: label1
            text: formatTime(mediaPlayer.position)
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            color: "white"
        }

        Slider {
            id: slider
            from: 0
            to: mediaPlayer.duration

            stepSize: 1000
            onMoved: {
                timer.restart()

                if(mediaPlayer.playbackState != MediaPlayer.PlayingState)
                    mediaPlayer.play()
                mediaPlayer.position = value
            }

            value: mediaPlayer.position
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - (label1.width + label2.width)
        }

        Label {
            id: label2
            text: formatTime(mediaPlayer.duration)
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            color: "white"
        }
    }
}
