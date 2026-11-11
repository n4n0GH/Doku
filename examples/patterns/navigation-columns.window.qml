import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// A wide window shows the list and the page pushed from it side by side.
Kirigami.ApplicationWindow {
    id: root
    width: Kirigami.Units.gridUnit * 42
    height: Kirigami.Units.gridUnit * 20

    pageStack.defaultColumnWidth: Kirigami.Units.gridUnit * 16

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "Notes"

        ListView {
            currentIndex: 1
            model: ["Shopping list", "Meeting notes", "Book recommendations", "Holiday packing"]

            delegate: QQC2.ItemDelegate {
                required property string modelData
                width: ListView.view.width
                text: modelData
                icon.name: "text-x-generic"
                highlighted: ListView.isCurrentItem
            }
        }
    }

    Component {
        id: notePage
        Kirigami.Page {
            title: "Meeting notes"

            actions: Kirigami.Action {
                text: "Edit"
                icon.name: "document-edit"
            }

            QQC2.Label {
                anchors.fill: parent
                wrapMode: Text.WordWrap
                text: "Agenda\n\n1. Release schedule\n2. Design review\n3. Any other business"
            }
        }
    }

    Component.onCompleted: pageStack.push(notePage)
}
