import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// Colours come from the theme, so the panel adapts to any colour scheme.
Rectangle {
    width: Kirigami.Units.gridUnit * 12
    height: Kirigami.Units.gridUnit * 4
    radius: Kirigami.Units.cornerRadius

    Kirigami.Theme.colorSet: Kirigami.Theme.View
    Kirigami.Theme.inherit: false
    color: Kirigami.Theme.backgroundColor

    QQC2.Label {
        anchors.centerIn: parent
        text: "Storage is almost full"
        color: Kirigami.Theme.neutralTextColor
    }
}
