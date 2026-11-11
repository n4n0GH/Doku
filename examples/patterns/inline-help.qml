import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Item {
    implicitWidth: Kirigami.Units.gridUnit * 28
    implicitHeight: form.implicitHeight

    Kirigami.FormLayout {
        id: form
        anchors.fill: parent

        // Short help: one sentence right under the control.
        QQC2.CheckBox {
            Kirigami.FormData.label: "Updates:"
            text: "Install automatically"
            checked: true
        }
        QQC2.Label {
            text: "Updates are installed the next time the system restarts."
            font: Kirigami.Theme.smallFont
            opacity: 0.75
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        // Longer help: a help button that opens a popup.
        RowLayout {
            Kirigami.FormData.label: "Privacy:"
            spacing: Kirigami.Units.smallSpacing

            QQC2.CheckBox {
                text: "Share usage statistics"
            }
            Kirigami.ContextualHelpButton {
                toolTipText: "Anonymous numbers such as how often the app is opened. No file names or personal data are sent."
            }
        }
    }
}
