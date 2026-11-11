import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

ColumnLayout {
    spacing: Kirigami.Units.smallSpacing

    Kirigami.Heading {
        text: "Heading level 1"
        level: 1
    }
    Kirigami.Heading {
        text: "Heading level 2"
        level: 2
    }
    Kirigami.Heading {
        text: "Heading level 3"
        level: 3
    }
    Kirigami.Heading {
        text: "Heading level 4"
        level: 4
    }
    QQC2.Label {
        text: "Label: the body text used everywhere else"
    }
    QQC2.Label {
        text: "Label with Kirigami.Theme.smallFont, for captions"
        font: Kirigami.Theme.smallFont
    }
    QQC2.Label {
        text: "Label with Kirigami.Theme.fixedWidthFont, for code"
        font: Kirigami.Theme.fixedWidthFont
    }
}
