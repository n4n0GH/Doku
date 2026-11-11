import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

ColumnLayout {
    width: Kirigami.Units.gridUnit * 16
    spacing: Kirigami.Units.largeSpacing

    Kirigami.SearchField {
        Layout.fillWidth: true
    }

    Kirigami.ActionTextField {
        Layout.fillWidth: true
        text: "konqi@example.org"

        rightActions: Kirigami.Action {
            icon.name: "edit-copy"
            text: "Copy"
        }
    }

    Kirigami.PasswordField {
        Layout.fillWidth: true
        text: "correct horse"
    }
}
