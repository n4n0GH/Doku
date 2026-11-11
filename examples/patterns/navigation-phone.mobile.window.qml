import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// The same two pages on a phone: only the newest page is visible, with a
// back button, and the tab bar sits at the bottom within reach of thumbs.
Kirigami.ApplicationWindow {
    id: root
    width: Kirigami.Units.gridUnit * 20
    height: Kirigami.Units.gridUnit * 34

    footer: Kirigami.NavigationTabBar {
        actions: [
            Kirigami.Action {
                text: "Notes"
                icon.name: "view-list-text"
                checked: true
            },
            Kirigami.Action {
                text: "Favourites"
                icon.name: "bookmarks"
            },
            Kirigami.Action {
                text: "Trash"
                icon.name: "user-trash"
            }
        ]
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "Notes"

        ListView {
            model: ["Shopping list", "Meeting notes", "Book recommendations", "Holiday packing"]

            delegate: QQC2.ItemDelegate {
                required property string modelData
                width: ListView.view.width
                text: modelData
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
