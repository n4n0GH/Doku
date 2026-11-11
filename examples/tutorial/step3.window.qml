import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: "Tasks"
    width: Kirigami.Units.gridUnit * 24
    height: Kirigami.Units.gridUnit * 28

    ListModel {
        id: tasksModel

        ListElement { title: "Water the plants"; done: true }
        ListElement { title: "Reply to Konqi"; done: false }
        ListElement { title: "Book train tickets"; done: false }
    }

    function addTask(title: string): void {
        const trimmed = title.trim()
        if (trimmed.length > 0) {
            tasksModel.append({ title: trimmed, done: false })
        }
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "Tasks"

        // Stays in place above the list while the list scrolls.
        header: QQC2.ToolBar {
            contentItem: Kirigami.ActionTextField {
                id: newTaskField

                placeholderText: "Add a task"
                onAccepted: {
                    root.addTask(text)
                    clear()
                }

                rightActions: Kirigami.Action {
                    text: "Add Task"
                    icon.name: "list-add"
                    enabled: newTaskField.text.trim().length > 0
                    onTriggered: newTaskField.accepted()
                }
            }
        }

        ListView {
            model: tasksModel
            // Rows are ticked, not selected, so none is marked as current.
            currentIndex: -1

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
