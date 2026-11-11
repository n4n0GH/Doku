import QtQuick
import org.kde.kirigami as Kirigami

Item {
    implicitWidth: Kirigami.Units.gridUnit * 22
    implicitHeight: Kirigami.Units.gridUnit * 9

    Kirigami.LoadingPlaceholder {
        anchors.centerIn: parent
        text: "Importing photos…"
        explanation: "312 of 840"
        determinate: true
        progressBar.value: 37
    }
}
