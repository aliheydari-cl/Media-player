import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {

    Row {
        anchors.fill: parent
        ToolButton {
            id: lsoundButton
            width: 25
            icon.source: "qrc:/icon/Lsound.png"
            icon.color: "white"
            icon.width: 30
            icon.height: 30
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                timer.restart()
                audioOutput.volume = 0
                soundSlider.value = 0

                p1.target = lsoundButton
                p2.target = lsoundButton
                anim.start()
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

            handle: Rectangle {}

            onMoved: {
                timer.restart()
                settings.soundValue = value
            }
        }

        ToolButton {
            id: hsoundButton
            width: 25
            icon.source: "qrc:/icon/Hsound.png"
            icon.color: "white"
            icon.width: 30
            icon.height: 30
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                timer.restart()
                audioOutput.volume = 1
                soundSlider.value = 1

                p1.target = hsoundButton
                p2.target = hsoundButton
                anim.start()
            }
        }
    }

    SequentialAnimation {
        id: anim

        PropertyAnimation {
            id: p1
            property: "scale"
            to: 1.2
            duration: 100
            easing.type: Easing.InOutQuad
        }

        PropertyAnimation {
            id: p2
            property: "scale"
            to: 1.0
            duration: 100
            easing.type: Easing.InOutQuad
        }
    }

}
