import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {

    Row {
        anchors.fill: parent
        ToolButton {
            width: 25
            icon.source: "icon/Lsound"
            icon.color: "white"
            icon.width: 30
            icon.height: 30
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                timer.restart()
                audioOutput.volume = 0
                soundSlider.value = 0
            }

        }

        Slider {
            id: soundSlider
            width: 80
            from: 0
            to: 1
            stepSize: 0.1
            value: audioOutput.volume
            anchors.verticalCenter: parent.verticalCenter

            handle: Rectangle {

            }

            onMoved: {
                timer.restart()
                audioOutput.volume = value
            }


        }

        ToolButton {
            width: 25
            icon.source: "icon/Hsound"
            icon.color: "white"
            icon.width: 30
            icon.height: 30
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                timer.restart()
                audioOutput.volume = 1
                soundSlider.value = 1
            }
        }
    }
}
