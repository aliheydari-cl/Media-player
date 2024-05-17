import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: setting
    title: "Setting"
    width: columnLayout + 20

    ColumnLayout {
        id: columnLayout

        RowLayout {

            Image {
                source: "icon/dark-mode.png"
                sourceSize.width: 20
                sourceSize.height: 20
            }

            Text {
                text: "Dark mode"
            }

            CheckBox {
                checked: settings.darkMode
                onCheckedChanged:{
                    if(checkState === Qt.Checked)
                    {
                        window.color = "black"
                        settings.darkMode = true
                    }
                    else
                    {
                        window.color = "white"
                        settings.darkMode = false
                    }
                }
            }
        }

        RowLayout {

            Image {
                source: "icon/time.png"
                sourceSize.width: 20
                sourceSize.height: 20
            }

            Text {
                text: "Display time (s)"


                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    ToolTip.text: "Buttons disappear when the user <br> does not move the mouse or click"
                    ToolTip.timeout: 6000
                    onEntered: ToolTip.visible = true
                    onExited: ToolTip.visible = false
                }
            }

            Slider {
                id: slider
                from: 1000
                to: 10000
                value: timer.interval
                stepSize: 1000
                snapMode: Slider.SnapOnRelease

                onValueChanged: {
                    settings.sliderValue = value
                }
            }

            Label {
                text: slider.value / 1000 + " s"
            }
        }
    }

    standardButtons: Dialog.Close | Dialog.Ok
}


