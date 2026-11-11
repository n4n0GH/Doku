import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// Related controls sit smallSpacing apart; groups sit largeSpacing apart.
ColumnLayout {
    spacing: Kirigami.Units.largeSpacing

    ColumnLayout {
        spacing: Kirigami.Units.smallSpacing

        Kirigami.Heading {
            text: "Notifications"
            level: 4
        }
        QQC2.CheckBox {
            text: "Show a popup"
            checked: true
        }
        QQC2.CheckBox {
            text: "Play a sound"
        }
    }

    ColumnLayout {
        spacing: Kirigami.Units.smallSpacing

        Kirigami.Heading {
            text: "Do Not Disturb"
            level: 4
        }
        QQC2.CheckBox {
            text: "While sharing the screen"
            checked: true
        }
        QQC2.CheckBox {
            text: "While an app is in full screen"
        }
    }
}
