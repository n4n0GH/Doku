import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

ColumnLayout {
    width: Kirigami.Units.gridUnit * 26

    Kirigami.InlineMessage {
        Layout.fillWidth: true
        visible: true
        type: Kirigami.MessageType.Error
        text: "The server did not respond. Check the network connection and try again."
        showCloseButton: true

        actions: [
            Kirigami.Action {
                text: "Try Again"
                icon.name: "view-refresh"
            },
            Kirigami.Action {
                text: "Network Settings"
                icon.name: "configure"
            }
        ]
    }
}
