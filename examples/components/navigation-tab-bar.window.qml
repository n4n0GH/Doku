import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    width: Kirigami.Units.gridUnit * 30
    height: Kirigami.Units.gridUnit * 16

    header: Kirigami.NavigationTabBar {
        actions: [
            Kirigami.Action {
                text: "Clock"
                icon.name: "clock"
                checked: true
            },
            Kirigami.Action {
                text: "Alarms"
                icon.name: "notifications"
            },
            Kirigami.Action {
                text: "Stopwatch"
                icon.name: "chronometer"
            },
            Kirigami.Action {
                text: "Timers"
                icon.name: "player-time"
            }
        ]
    }

    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.None
    pageStack.initialPage: Kirigami.Page {
        Kirigami.Heading {
            anchors.centerIn: parent
            text: "10:42"
            level: 1
            font.pointSize: 40
        }
    }
}
