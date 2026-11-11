// Screenshot variant of step6: the same app with the Active filter on.
import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kitemmodels as KItemModels

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

    // Which tasks to show: "all", "active" or "completed".
    property string filter: "active"
    onFilterChanged: visibleTasks.invalidateFilter()

    // Sits between the data and the list and lets only matching rows through.
    KItemModels.KSortFilterProxyModel {
        id: visibleTasks
        sourceModel: tasksModel

        filterRowCallback: (row, parent) => {
            const done = tasksModel.get(row).done
            return root.filter === "all"
                || (root.filter === "active" && !done)
                || (root.filter === "completed" && done)
        }
    }

    // The list shows filtered rows; this finds a row's place in the real data.
    function sourceRow(row: int): int {
        return visibleTasks.mapToSource(visibleTasks.index(row, 0)).row
    }

    function clearCompleted(): void {
        for (let i = tasksModel.count - 1; i >= 0; i--) {
            if (tasksModel.get(i).done) {
                tasksModel.remove(i)
            }
        }
    }

    // How many tasks are still open. Recounted whenever the list changes.
    property int remaining: 0

    function recount(): void {
        let open = 0
        for (let i = 0; i < tasksModel.count; i++) {
            if (!tasksModel.get(i).done) {
                open++
            }
        }
        remaining = open
    }

    Connections {
        target: tasksModel
        function onCountChanged() { root.recount() }
        function onDataChanged() {
            root.recount()
            visibleTasks.invalidateFilter()
        }
    }

    Component.onCompleted: recount()

    function addTask(title: string): void {
        const trimmed = title.trim()
        if (trimmed.length > 0) {
            tasksModel.append({ title: trimmed, done: false })
        }
    }

    function deleteTask(row: int): void {
        // Keep a copy so the deletion can be undone.
        const task = { title: tasksModel.get(row).title, done: tasksModel.get(row).done }
        tasksModel.remove(row)
        showPassiveNotification("“" + task.title + "” deleted", "long", "Undo",
            () => tasksModel.insert(row, task))
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "Tasks"

        actions: [
            Kirigami.Action {
                text: "Show"
                icon.name: "view-filter"

                Kirigami.Action {
                    text: "All Tasks"
                    checkable: true
                    autoExclusive: true
                    checked: root.filter === "all"
                    onTriggered: root.filter = "all"
                }
                Kirigami.Action {
                    text: "Active"
                    checkable: true
                    autoExclusive: true
                    checked: root.filter === "active"
                    onTriggered: root.filter = "active"
                }
                Kirigami.Action {
                    text: "Completed"
                    checkable: true
                    autoExclusive: true
                    checked: root.filter === "completed"
                    onTriggered: root.filter = "completed"
                }
            },
            Kirigami.Action {
                text: "Clear Completed"
                icon.name: "edit-clear-all"
                enabled: root.remaining < tasksModel.count
                onTriggered: root.clearCompleted()
            }
        ]

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

        footer: QQC2.ToolBar {
            visible: tasksModel.count > 0

            contentItem: QQC2.Label {
                leftPadding: Kirigami.Units.largeSpacing
                text: root.remaining === 1 ? "1 task left" : root.remaining + " tasks left"
            }
        }

        ListView {
            id: tasksView
            model: visibleTasks
            // Rows are ticked, not selected, so none is marked as current.
            currentIndex: -1

            Kirigami.PlaceholderMessage {
                anchors.centerIn: parent
                width: parent.width - Kirigami.Units.gridUnit * 4
                visible: tasksView.count === 0

                icon.name: "checkmark"
                text: tasksModel.count === 0 ? "No tasks" : "Nothing to show"
                explanation: tasksModel.count === 0
                    ? "Type in the field above and press Enter to add one."
                    : "No tasks match the current filter."
            }

            delegate: QQC2.ItemDelegate {
                id: row

                required property string title
                required property bool done
                required property int index

                width: ListView.view.width

                // Clicking anywhere on the row ticks or unticks the task.
                onClicked: tasksModel.setProperty(root.sourceRow(index), "done", !done)

                contentItem: RowLayout {
                    spacing: Kirigami.Units.smallSpacing

                    QQC2.CheckBox {
                        checked: row.done
                        onToggled: tasksModel.setProperty(root.sourceRow(row.index), "done", checked)
                    }

                    QQC2.Label {
                        Layout.fillWidth: true
                        text: row.title
                        elide: Text.ElideRight

                        // Finished tasks step back: struck through and faded.
                        font.strikeout: row.done
                        opacity: row.done ? 0.6 : 1
                    }

                    QQC2.ToolButton {
                        text: "Delete"
                        icon.name: "edit-delete"
                        display: QQC2.AbstractButton.IconOnly
                        onClicked: root.deleteTask(root.sourceRow(row.index))

                        QQC2.ToolTip.text: text
                        QQC2.ToolTip.visible: hovered
                        QQC2.ToolTip.delay: Kirigami.Units.toolTipDelay
                    }
                }
            }
        }
    }
}
