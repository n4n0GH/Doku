import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// Controls for the list itself sit in a header that belongs to the list.
QQC2.ScrollView {
    width: Kirigami.Units.gridUnit * 20
    height: Kirigami.Units.gridUnit * 10

    Kirigami.Theme.colorSet: Kirigami.Theme.View
    Kirigami.Theme.inherit: false
    background: Rectangle {
        color: Kirigami.Theme.backgroundColor
    }

    ListView {
        currentIndex: -1
        model: ["Konqi", "Katie", "Kandalf"]

        headerPositioning: ListView.OverlayHeader
        header: Kirigami.InlineViewHeader {
            width: ListView.view.width
            text: "Accounts"
            actions: [
                Kirigami.Action {
                    text: "Add Account"
                    icon.name: "list-add"
                }
            ]
        }

        delegate: QQC2.ItemDelegate {
            required property string modelData

            width: ListView.view.width
            text: modelData
            icon.name: "user"
        }
    }
}
