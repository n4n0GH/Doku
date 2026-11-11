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

        QQC2.Switch {
            Kirigami.FormData.label: "Night light:"
            checked: true
        }

        QQC2.CheckBox {
            Kirigami.FormData.label: "On startup:"
            text: "Restore open windows"
            checked: true
        }

        ColumnLayout {
            Kirigami.FormData.label: "Clicking files:"
            Kirigami.FormData.buddyFor: firstRadio
            spacing: Kirigami.Units.smallSpacing

            QQC2.RadioButton {
                id: firstRadio
                text: "Opens them"
            }
            QQC2.RadioButton {
                text: "Selects them"
                checked: true
            }
        }

        QQC2.ComboBox {
            Kirigami.FormData.label: "Language:"
            model: ["English", "Deutsch", "Español", "Français", "日本語"]
        }

        RowLayout {
            Kirigami.FormData.label: "Volume:"
            Kirigami.FormData.buddyFor: volume
            spacing: Kirigami.Units.smallSpacing

            QQC2.Slider {
                id: volume
                from: 0
                to: 100
                value: 65
            }
            QQC2.SpinBox {
                from: 0
                to: 100
                value: volume.value
            }
        }
    }
}
