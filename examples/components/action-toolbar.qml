import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// The same toolbar at two widths. When space runs out, actions move into
// the overflow menu at the end instead of being cut off.
ColumnLayout {
    spacing: Kirigami.Units.gridUnit

    Repeater {
        model: [Kirigami.Units.gridUnit * 30, Kirigami.Units.gridUnit * 13]

        QQC2.ToolBar {
            required property int modelData
            Layout.preferredWidth: modelData

            contentItem: Kirigami.ActionToolBar {
                actions: [
                    Kirigami.Action {
                        text: "New"
                        icon.name: "document-new"
                    },
                    Kirigami.Action {
                        text: "Open"
                        icon.name: "document-open"
                    },
                    Kirigami.Action {
                        text: "Save"
                        icon.name: "document-save"
                    },
                    Kirigami.Action {
                        text: "Share"
                        icon.name: "document-share"
                    },
                    Kirigami.Action {
                        text: "Print"
                        icon.name: "document-print"
                    }
                ]
            }
        }
    }
}
