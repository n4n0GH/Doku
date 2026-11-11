import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    width: Kirigami.Units.gridUnit * 34
    height: Kirigami.Units.gridUnit * 18

    globalDrawer: Kirigami.GlobalDrawer {
        modal: false
        title: "Photos"
        titleIcon: "applications-graphics"

        actions: [
            Kirigami.Action {
                text: "Library"
                icon.name: "view-list-icons"
                checked: true
            },
            Kirigami.Action {
                text: "Albums"
                icon.name: "folder-pictures"
            },
            Kirigami.Action {
                text: "People"
                icon.name: "user"
            },
            Kirigami.Action {
                text: "Places"
                icon.name: "mark-location"
            },
            Kirigami.Action {
                separator: true
            },
            Kirigami.Action {
                text: "Settings"
                icon.name: "configure"
            }
        ]
    }

    pageStack.initialPage: Kirigami.Page {
        title: "Library"

        Kirigami.PlaceholderMessage {
            anchors.centerIn: parent
            width: parent.width - Kirigami.Units.gridUnit * 4
            text: "No photos yet"
        }
    }
}
