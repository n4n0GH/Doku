import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// The same icon name, asked for at two sizes. Small sizes get a monochrome
// line drawing that follows the text colour; large sizes get full colour.
GridLayout {
    columns: 2
    columnSpacing: Kirigami.Units.gridUnit * 2
    rowSpacing: Kirigami.Units.smallSpacing

    RowLayout {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        spacing: Kirigami.Units.largeSpacing

        Repeater {
            model: ["folder-symbolic", "document-save-symbolic", "edit-delete-symbolic", "configure-symbolic"]
            Kirigami.Icon {
                required property string modelData
                source: modelData
                implicitWidth: Kirigami.Units.iconSizes.smallMedium
                implicitHeight: Kirigami.Units.iconSizes.smallMedium
            }
        }
    }
    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: Kirigami.Units.largeSpacing

        Repeater {
            model: ["folder", "user-trash", "preferences-system", "applications-internet"]
            Kirigami.Icon {
                required property string modelData
                source: modelData
                implicitWidth: Kirigami.Units.iconSizes.large
                implicitHeight: Kirigami.Units.iconSizes.large
            }
        }
    }
    QQC2.Label {
        Layout.alignment: Qt.AlignHCenter
        text: "Symbolic, 22 px"
    }
    QQC2.Label {
        Layout.alignment: Qt.AlignHCenter
        text: "Full colour, 48 px"
    }
}
