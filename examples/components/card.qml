import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Item {
    implicitWidth: Kirigami.Units.gridUnit * 20
    implicitHeight: card.implicitHeight + Kirigami.Units.largeSpacing * 2

    Kirigami.Card {
        id: card
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing

        banner {
            source: Qt.resolvedUrl("../assets/landscape.png")
            title: "Alpine Loop"
            titleAlignment: Qt.AlignLeft | Qt.AlignBottom
        }

        contentItem: QQC2.Label {
            wrapMode: Text.WordWrap
            text: "A 12 km circular walk with views over the valley. Allow four hours."
        }

        actions: [
            Kirigami.Action {
                text: "Directions"
                icon.name: "map-symbolic"
            },
            Kirigami.Action {
                text: "Save"
                icon.name: "bookmark-new"
            }
        ]
    }
}
