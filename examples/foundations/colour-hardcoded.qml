import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// Hard-coded colours: fine in the scheme they were picked for, wrong in
// every other one.
Rectangle {
    width: Kirigami.Units.gridUnit * 12
    height: Kirigami.Units.gridUnit * 4
    radius: Kirigami.Units.cornerRadius
    color: "#ffffff"

    QQC2.Label {
        anchors.centerIn: parent
        text: "Storage is almost full"
        color: "#ffb347"
    }
}
