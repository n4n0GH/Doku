import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

// A title and its subtitle belong together: no spacing between them.
ColumnLayout {
    spacing: 0

    Kirigami.Heading {
        text: "Apples in the sunlight"
        level: 2
    }
    QQC2.Label {
        text: "And pears in the moonlight"
        opacity: 0.75
    }
}
