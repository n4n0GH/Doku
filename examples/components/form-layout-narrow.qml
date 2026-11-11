import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// The same form in a narrow window: labels move above their controls.
Item {
    implicitWidth: Kirigami.Units.gridUnit * 13
    implicitHeight: form.implicitHeight + Kirigami.Units.largeSpacing * 2

    Kirigami.FormLayout {
        id: form
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing
        wideMode: false

        QQC2.TextField {
            Kirigami.FormData.label: "Name:"
            text: "Konqi"
        }
        QQC2.TextField {
            Kirigami.FormData.label: "Email:"
            placeholderText: "konqi@example.org"
        }
        QQC2.ComboBox {
            Kirigami.FormData.label: "Theme:"
            model: ["Follow system", "Light", "Dark"]
        }
    }
}
