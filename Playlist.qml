import QtQuick
import QtQuick.Controls.Material

Dialog {
    id: dialog
    title: "Playlist"

    property var listModel: listModel

    ListView {
        id: listview
        anchors.fill: parent
        model: listModel

        delegate: Rectangle {
            width: listview.width
            height: path.height + 10

            Text {
                id: path
                wrapMode: Text.Wrap
                text: model.path
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    right: deleteButton.left
                }
            }

            ToolButton {
                id: deleteButton
                icon.source: "icon/delete.png"
                width: 40

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right

                onClicked: {
                    database.deleteFromDatabase(listModel.get(index).path)

                    listModel.remove(index)
                    if(listModel.count === 0)
                        currentIndex = -1
                }
            }
        }
    }

    ListModel {
        id: listModel
    }

    standardButtons: Dialog.Close
}
