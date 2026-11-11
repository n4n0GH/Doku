import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

GridLayout {
    columns: 2
    columnSpacing: Kirigami.Units.largeSpacing
    rowSpacing: Kirigami.Units.largeSpacing

    QQC2.Label {
        text: "Known amount:"
        Layout.alignment: Qt.AlignRight
    }
    QQC2.ProgressBar {
        Layout.preferredWidth: Kirigami.Units.gridUnit * 12
        from: 0
        to: 100
        value: 62
    }

    QQC2.Label {
        text: "Unknown amount:"
        Layout.alignment: Qt.AlignRight
    }
    QQC2.BusyIndicator {
        running: true
        implicitWidth: Kirigami.Units.iconSizes.medium
        implicitHeight: Kirigami.Units.iconSizes.medium
    }
}
