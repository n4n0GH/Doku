// Screenshot variant of step5: the same app with no tasks.
import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: "Tasks"
    width: Kirigami.Units.gridUnit * 24
    height: Kirigami.Units.gridUnit * 28

    ListModel {
        id: tasksModel
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
        function onDataChanged() { root.recount() }
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
            model: tasksModel
            // Rows are ticked, not selected, so none is marked as current.
            currentIndex: -1

            Kirigami.PlaceholderMessage {
                anchors.centerIn: parent
                width: parent.width - Kirigami.Units.gridUnit * 4
                visible: tasksView.count === 0

                icon.name: "checkmark"
                text: "No tasks"
                explanation: "Type in the field above and press Enter to add one."
            }

            delegate: QQC2.ItemDelegate {
                id: row

                required property string title
                required property bool done
                required property int index

                width: ListView.view.width

                // Clicking anywhere on the row ticks or unticks the task.
                onClicked: tasksModel.setProperty(index, "done", !done)

                contentItem: RowLayout {
                    spacing: Kirigami.Units.smallSpacing

                    QQC2.CheckBox {
                        checked: row.done
                        onToggled: tasksModel.setProperty(row.index, "done", checked)
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
                        onClicked: root.deleteTask(row.index)

                        QQC2.ToolTip.text: text
                        QQC2.ToolTip.visible: hovered
                        QQC2.ToolTip.delay: Kirigami.Units.toolTipDelay
                    }
                }
            }
        }
    }
}
