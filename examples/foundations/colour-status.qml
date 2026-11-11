import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// Status colours always travel with an icon and words, never alone.
ColumnLayout {
    spacing: Kirigami.Units.smallSpacing

    Repeater {
        model: [
            { icon: "emblem-success", text: "Backup finished", color: Kirigami.Theme.positiveTextColor },
            { icon: "emblem-warning", text: "Battery is low", color: Kirigami.Theme.neutralTextColor },
            { icon: "emblem-error", text: "Could not connect", color: Kirigami.Theme.negativeTextColor },
            { icon: "emblem-information", text: "3 updates available", color: Kirigami.Theme.activeTextColor }
        ]

        RowLayout {
            required property var modelData
            spacing: Kirigami.Units.smallSpacing

            Kirigami.Icon {
                source: parent.modelData.icon
                implicitWidth: Kirigami.Units.iconSizes.small
                implicitHeight: Kirigami.Units.iconSizes.small
            }
            QQC2.Label {
                text: parent.modelData.text
                color: parent.modelData.color
            }
        }
    }
}
