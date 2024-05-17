import QtQuick
import QtQuick.Controls.Material
import QtMultimedia
import QtQuick.Dialogs
import QtQuick.Layouts
import QtCore
import Database 1.0

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Media Player")
    color: {
        if(settings.darkMode)
            "black"
        else
            "white"
    }

    minimumHeight: 400
    minimumWidth: 640

    Database {
        id:database
    }

    Settings{
        id: settings
        property int sliderValue: 5000
        property bool darkMode
        property double soundValue: 0.5
    }

    background: MouseArea {
            anchors.fill: parent
            enabled: mediaPlayer.playbackState === MediaPlayer.PlayingState

            onClicked: {
                timer.restart()

                if(footer.opacity === 1)
                    hideControls.start()
                else
                    showControls.start()
            }
            hoverEnabled: true

            onPositionChanged: {
                timer.restart()
                showControls.start()
            }
    }

    MediaPlayer {
        id: mediaPlayer
        videoOutput: videoOutput
        audioOutput: audioOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }

    AudioOutput {
        id: audioOutput
        volume: settings.soundValue
    }

    Item {
        id: footer

        Rectangle {
            anchors.fill: footer
            color: "black"
            opacity: 0.4
        }

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60

        ScreenSetting {
            id: screenSetting
            width: 35
            anchors.bottom: footer.bottom
            anchors.left: footer.left
            anchors.verticalCenter: footer.verticalCenter
            anchors.leftMargin: 5
        }

        RowLayout {
            width: 40
            anchors.left: screenSetting.right
            anchors.verticalCenter: footer.verticalCenter
            anchors.leftMargin: 10
            spacing: 0

            ToolButton{
                id: replayButton
                icon.source: "icon/replay.png"
                icon.color: "white"

                onClicked: {
                    timer.restart()
                    mediaPlayer.position -= 10000

                    p1.target = replayButton
                    p2.target = replayButton
                    anim.start()
                }
            }

            ToolButton {
                id: forwardButton
                icon.source: "icon/forward.png"
                icon.color: "white"

                onClicked: {
                    timer.restart()
                    mediaPlayer.position += 10000

                    p1.target = forwardButton
                    p2.target = forwardButton
                    anim.start()
                }
            }
        }

        MediaControls {
            id: mediaControls
            width: footer.width

            anchors.verticalCenter: footer.verticalCenter
            anchors.bottom: footer.bottom
            anchors.left: footer.left
            anchors.right: footer.right
        }

        Item {
            id: speedControl
            width: 40
            height: 40
            anchors.right: soundControls.left
            anchors.verticalCenter: footer.verticalCenter
            anchors.rightMargin: 5

            MouseArea {
                anchors.fill: parent

                onClicked:  {
                    timer.restart()

                    if(mediaPlayer.playbackRate === 2)
                        mediaPlayer.playbackRate = 0.5
                    else
                        mediaPlayer.playbackRate += 0.5;

                    text.text = mediaPlayer.playbackRate + "x"

                    p1.target = text
                    p2.target = text
                    anim.start()
                }
            }

            Text {
                id: text
                anchors.centerIn: speedControl
                text: mediaPlayer.playbackRate.toFixed(1) + "x"
                font.bold: true
                color: "white"
            }
        }

        SoundControls {
            id: soundControls
            width: 130
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 5
        }
    }

    TimeSlider {
        id: timeSlider
        width: parent.width
        height: 20

        anchors.bottom: footer.top
        anchors.left: window.left
        anchors.right: window.right
        anchors.bottomMargin: 10
    }

    property int currentIndex: -1

    FileDialog {
        id: fileDialog
        title: "Select a video"
        nameFilters: [
            "Video Files (*.mp4 *.avi *.mkv *.mov *.wmv)",
            "All Files (*)"
        ]
        onAccepted: {
            timer.restart()
            playlist.listModel.append({path: selectedFile.toString()})
            mediaPlayer.source = selectedFile
            database.addToDatabase(selectedFile)
            currentIndex ++
            mediaPlayer.play()
        }
    }

    Playlist {
        id:playlist
        width: parent.width / 2

        x: Math.round((window.width - width) / 2)
        y: Math.round(window.height / 6)

        height: 300
    }

    Setting {
        id: setting

        x: Math.round((window.width - width) / 2)
        y: Math.round(window.height / 6)

        height: 300
    }

    Menu {
        id: menu
        x: parent.width
        MenuItem {
            text: "add video"
            icon.source: "icon/addFile.png"
            onTriggered: fileDialog.open()
        }

        MenuItem {
            text: "show playlist"
            icon.source: "icon/list.png"
            onTriggered: playlist.open()
        }

        MenuItem {
            text: "Setting"
            icon.source: "icon/setting.png"

            onTriggered: setting.open()
        }
    }

    ToolButton {
        id:addFileButton
        icon.source: "icon/menu.png"
        icon.color: {
            if(settings.darkMode)
                "white"
            else
                "black"
        }

        anchors.right: parent.right
        onClicked: {
            timer.restart()

            menu.open()
        }
    }

    property var footerHeight
    property var timeSliderHeight

    Component.onCompleted: {
        footerHeight = footer.height
        timeSliderHeight = timeSlider.height

        database.getDatabase()
        for (var i = 0; i < database.playlist.length; i++)
            playlist.listModel.append({path: database.playlist[i]})
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


    ParallelAnimation {
        id: hideControls

        PropertyAnimation {
            target: footer
            property: "height"
            to: 0
            duration: 800
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target: footer
            property: "opacity"
            to: 0
            duration: 800
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target: timeSlider
            property: "height"
            to: 0
            duration: 800
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target: timeSlider
            property: "opacity"
            to: 0
            duration: 800
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target: addFileButton
            property: "opacity"
            to: 0
            duration: 800
            easing.type: Easing.OutQuad
        }
    }

    ParallelAnimation {
        id: showControls

        PropertyAnimation {
            target: footer
            property: "height"
            to: footerHeight
            duration: 800
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target: footer
            property: "opacity"
            to: 1
            duration: 800
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target: timeSlider
            property: "height"
            to: timeSliderHeight
            duration: 800
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target: timeSlider
            property: "opacity"
            to: 1
            duration: 800
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target: addFileButton
            property: "opacity"
            to: 1
            duration: 800
            easing.type: Easing.OutQuad
        }
    }

    Timer {
        id: timer
        interval: settings.sliderValue
        repeat: true
        running: mediaPlayer.playbackState === MediaPlayer.PlayingState

        onTriggered: {
            if(mediaPlayer.playbackState === MediaPlayer.PlayingState)
                hideControls.start()
        }
    }
}



















