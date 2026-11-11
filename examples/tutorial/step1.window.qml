import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: "Tasks"
    width: Kirigami.Units.gridUnit * 24
    height: Kirigami.Units.gridUnit * 28

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "Tasks"

        QQC2.Label {
            text: "Nothing here yet."
        }
    }
}
