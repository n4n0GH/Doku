import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    width: Kirigami.Units.gridUnit * 30
    height: Kirigami.Units.gridUnit * 16

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "All Notes"

        ListView {
            currentIndex: -1
            model: ["Shopping list", "Book recommendations", "Holiday packing"]

            delegate: QQC2.ItemDelegate {
                required property string modelData
                width: ListView.view.width
                text: modelData
                icon.name: "text-x-generic"
            }
        }
    }

    // Do the thing at once, then offer a way back for a few seconds.
    Component.onCompleted: root.showPassiveNotification(
        "“Meeting notes” moved to the trash", "long", "Undo", () => {})
}
