import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

RowLayout {
    spacing: Kirigami.Units.gridUnit

    Repeater {
        model: [
            { name: "small", size: Kirigami.Units.iconSizes.small },
            { name: "smallMedium", size: Kirigami.Units.iconSizes.smallMedium },
            { name: "medium", size: Kirigami.Units.iconSizes.medium },
            { name: "large", size: Kirigami.Units.iconSizes.large },
            { name: "huge", size: Kirigami.Units.iconSizes.huge }
        ]

        ColumnLayout {
            required property var modelData
            Layout.alignment: Qt.AlignBottom
            spacing: Kirigami.Units.smallSpacing

            Kirigami.Icon {
                Layout.alignment: Qt.AlignHCenter
                source: "folder"
                implicitWidth: parent.modelData.size
                implicitHeight: parent.modelData.size
            }
            QQC2.Label {
                Layout.alignment: Qt.AlignHCenter
                text: parent.modelData.name
            }
            QQC2.Label {
                Layout.alignment: Qt.AlignHCenter
                text: parent.modelData.size + " px"
                opacity: 0.75
            }
        }
    }
}
