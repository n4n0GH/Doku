import QtQuick
import org.kde.kirigami as Kirigami

Item {
    implicitWidth: Kirigami.Units.gridUnit * 24
    implicitHeight: Kirigami.Units.gridUnit * 16

    Kirigami.PlaceholderMessage {
        anchors.centerIn: parent
        width: parent.width - Kirigami.Units.gridUnit * 4

        icon.name: "network-bluetooth"
        text: "No devices found"
        explanation: "Make sure the device is switched on and close to this computer."

        helpfulAction: Kirigami.Action {
            icon.name: "view-refresh"
            text: "Search Again"
        }
    }
}
