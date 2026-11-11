import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

ColumnLayout {
    spacing: Kirigami.Units.largeSpacing

    // Removable: tags the user added.
    RowLayout {
        spacing: Kirigami.Units.smallSpacing

        Repeater {
            model: ["Holiday", "2026", "Family"]
            Kirigami.Chip {
                required property string modelData
                text: modelData
            }
        }
    }

    // Toggles: filters that can be switched on and off.
    RowLayout {
        spacing: Kirigami.Units.smallSpacing

        Kirigami.Chip {
            text: "Photos"
            closable: false
            checkable: true
            checked: true
        }
        Kirigami.Chip {
            text: "Videos"
            closable: false
            checkable: true
        }
        Kirigami.Chip {
            text: "Screenshots"
            closable: false
            checkable: true
        }
    }

    // Read-only: properties that are simply shown.
    RowLayout {
        spacing: Kirigami.Units.smallSpacing

        Kirigami.Chip {
            text: "GPL-3.0"
            icon.name: "license"
            closable: false
            interactive: false
        }
        Kirigami.Chip {
            text: "Linux"
            closable: false
            interactive: false
        }
    }
}
