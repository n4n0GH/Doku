import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Item {
    implicitWidth: Kirigami.Units.gridUnit * 28
    implicitHeight: form.implicitHeight + Kirigami.Units.largeSpacing * 2

    Kirigami.FormLayout {
        id: form
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing

        QQC2.TextField {
            Kirigami.FormData.label: "Name:"
            text: "Konqi"
        }
        QQC2.TextField {
            Kirigami.FormData.label: "Email:"
            placeholderText: "konqi@example.org"
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Appearance"
        }

        QQC2.ComboBox {
            Kirigami.FormData.label: "Theme:"
            model: ["Follow system", "Light", "Dark"]
        }
        QQC2.CheckBox {
            Kirigami.FormData.label: "Text:"
            text: "Use large text"
        }
        QQC2.CheckBox {
            text: "Use bold text"
            checked: true
        }
    }
}
