import QtQuick
import QtQuick.Controls.Material

Dialog {
    id: dialog

    property var listModel: listModel

    ListView {
        id: listview
        anchors.fill: parent

        model: listModel

        delegate: Rectangle {
            width: parent.width
            height: path.height + 10

            Text {
                width: parent.width
                id: path
                wrapMode: Text.Wrap
                text: model.path
            }
        }
    }

    ListModel {
        id: listModel

    }

    standardButtons: Dialog.Close
}




