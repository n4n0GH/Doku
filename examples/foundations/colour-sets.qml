import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// One swatch per colour set. Each swatch switches the set for itself and
// everything inside it, so the label picks up the matching text colour.
GridLayout {
    columns: 4
    rowSpacing: Kirigami.Units.largeSpacing
    columnSpacing: Kirigami.Units.largeSpacing

    Repeater {
        model: [
            { name: "View", set: Kirigami.Theme.View },
            { name: "Window", set: Kirigami.Theme.Window },
            { name: "Button", set: Kirigami.Theme.Button },
            { name: "Header", set: Kirigami.Theme.Header },
            { name: "Selection", set: Kirigami.Theme.Selection },
            { name: "Tooltip", set: Kirigami.Theme.Tooltip },
            { name: "Complementary", set: Kirigami.Theme.Complementary }
        ]

        Rectangle {
            id: swatch
            required property var modelData

            Kirigami.Theme.colorSet: modelData.set
            Kirigami.Theme.inherit: false

            implicitWidth: Kirigami.Units.gridUnit * 8
            implicitHeight: Kirigami.Units.gridUnit * 5
            radius: Kirigami.Units.cornerRadius
            color: Kirigami.Theme.backgroundColor
            border.color: Kirigami.ColorUtils.linearInterpolation(
                Kirigami.Theme.backgroundColor, Kirigami.Theme.textColor, Kirigami.Theme.frameContrast)

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 0

                QQC2.Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: swatch.modelData.name
                    font.bold: true
                }
                QQC2.Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Aa Bb Cc"
                    opacity: 0.75
                }
            }
        }
    }
}
