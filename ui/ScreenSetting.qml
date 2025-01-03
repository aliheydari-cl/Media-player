import QtQuick
import QtQuick.Controls.Material
import QtMultimedia

ToolButton {
    icon.source: videoOutput.fillMode === VideoOutput.PreserveAspectFit ? "qrc:/icon/fit.png" : "qrc:/icon/crop.png"
    icon.color: "white"

    onClicked: {
        timer.restart()

        if(videoOutput.fillMode === VideoOutput.PreserveAspectFit)
            videoOutput.fillMode = VideoOutput.PreserveAspectCrop
        else
            videoOutput.fillMode = VideoOutput.PreserveAspectFit
    }
}


