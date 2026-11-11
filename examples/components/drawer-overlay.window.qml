import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    width: Kirigami.Units.gridUnit * 30
    height: Kirigami.Units.gridUnit * 18

    pageStack.initialPage: Kirigami.Page {
        title: "Now Playing"

        Kirigami.Heading {
            anchors.centerIn: parent
            text: "Apples in the Sunlight"
        }
    }

    Kirigami.OverlayDrawer {
        edge: Qt.BottomEdge
        modal: true
        drawerOpen: true
        handleVisible: false

        contentItem: ColumnLayout {
            spacing: 0

            QQC2.ItemDelegate {
                Layout.fillWidth: true
                text: "Add to Playlist"
                icon.name: "list-add"
            }
            QQC2.ItemDelegate {
                Layout.fillWidth: true
                text: "Share"
                icon.name: "document-share"
            }
            QQC2.ItemDelegate {
                Layout.fillWidth: true
                text: "Show Album"
                icon.name: "media-album-cover"
            }
        }
    }
}
