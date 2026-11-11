import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    width: Kirigami.Units.gridUnit * 36
    height: Kirigami.Units.gridUnit * 22

    globalDrawer: Kirigami.GlobalDrawer {
        modal: false
        actions: [
            Kirigami.Action {
                text: "All Notes"
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
        title: "All Notes"

        actions: [
            Kirigami.Action {
                text: "New Note"
                icon.name: "list-add"
            },
            Kirigami.Action {
                text: "Search"
                icon.name: "search"
                displayHint: Kirigami.DisplayHint.IconOnly
            }
        ]

        ListView {
            model: ["Shopping list", "Meeting notes", "Book recommendations", "Holiday packing", "Recipe: apple pie"]

            delegate: QQC2.ItemDelegate {
                required property string modelData

                width: ListView.view.width
                text: modelData
                icon.name: "text-x-generic"
            }
        }
    }
}
