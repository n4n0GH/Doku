import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// A plain list: one line per item, grouped under section headers.
QQC2.ScrollView {
    width: Kirigami.Units.gridUnit * 20
    height: Kirigami.Units.gridUnit * 15

    // Lists live on the View colour set, the brightest surface.
    Kirigami.Theme.colorSet: Kirigami.Theme.View
    Kirigami.Theme.inherit: false
    background: Rectangle {
        color: Kirigami.Theme.backgroundColor
    }

    ListView {
        currentIndex: 1

        model: ListModel {
            ListElement { name: "Shopping list"; folder: "Personal" }
            ListElement { name: "Holiday packing"; folder: "Personal" }
            ListElement { name: "Recipe: apple pie"; folder: "Personal" }
            ListElement { name: "Meeting notes"; folder: "Work" }
            ListElement { name: "Release checklist"; folder: "Work" }
        }

        section.property: "folder"
        section.delegate: Kirigami.ListSectionHeader {
            required property string section
            width: ListView.view.width
            text: section
        }

        delegate: QQC2.ItemDelegate {
            required property string name
            required property int index

            width: ListView.view.width
            text: name
            icon.name: "text-x-generic"
            highlighted: ListView.isCurrentItem
        }
    }
}
