import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: "Tasks"
    width: Kirigami.Units.gridUnit * 24
    height: Kirigami.Units.gridUnit * 28

    // The data: one entry per task.
    ListModel {
        id: tasksModel

        ListElement { title: "Water the plants"; done: true }
        ListElement { title: "Reply to Konqi"; done: false }
        ListElement { title: "Book train tickets"; done: false }
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "Tasks"

        ListView {
            model: tasksModel
            // Rows are ticked, not selected, so none is marked as current.
            currentIndex: -1

            // The template for one row.
            delegate: QQC2.CheckDelegate {
                required property string title
                required property bool done

                width: ListView.view.width
                text: title
                checked: done
            }
        }
    }
}
