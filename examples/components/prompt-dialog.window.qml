import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    width: Kirigami.Units.gridUnit * 30
    height: Kirigami.Units.gridUnit * 18

    pageStack.initialPage: Kirigami.Page {
        title: "Meeting notes"

        QQC2.Label {
            anchors.fill: parent
            wrapMode: Text.WordWrap
            text: "Agenda\n\n1. Release schedule\n2. Design review\n3. Any other business"
        }
    }

    Kirigami.PromptDialog {
        Component.onCompleted: open()

        title: "Delete Note"
        subtitle: "“Meeting notes” will be moved to the trash."
        dialogType: Kirigami.PromptDialog.Warning
        standardButtons: Kirigami.Dialog.Cancel

        customFooterActions: Kirigami.Action {
            text: "Delete"
            icon.name: "edit-delete"
        }
    }
}
