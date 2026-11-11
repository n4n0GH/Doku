import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

QQC2.ToolBar {
    implicitWidth: Kirigami.Units.gridUnit * 24

    contentItem: Kirigami.ActionToolBar {
        actions: [
            Kirigami.Action {
                text: "Add Note"
                icon.name: "list-add"
                // Stays on the toolbar even when space is tight.
                displayHint: Kirigami.DisplayHint.KeepVisible
            },
            Kirigami.Action {
                text: "Search"
                icon.name: "search"
                // Well-known icon, so the label can be dropped.
                displayHint: Kirigami.DisplayHint.IconOnly
            },
            Kirigami.Action {
                text: "Sort"
                icon.name: "view-sort"

                // Child actions turn the button into a menu.
                Kirigami.Action {
                    text: "By Name"
                }
                Kirigami.Action {
                    text: "By Date"
                }
            },
            Kirigami.Action {
                text: "Settings"
                icon.name: "configure"
                // Rarely needed: lives in the overflow menu only.
                displayHint: Kirigami.DisplayHint.AlwaysHide
            }
        ]
    }
}
