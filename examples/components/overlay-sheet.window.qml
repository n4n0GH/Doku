import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    width: Kirigami.Units.gridUnit * 32
    height: Kirigami.Units.gridUnit * 20

    pageStack.initialPage: Kirigami.Page {
        title: "About"
    }

    Kirigami.OverlaySheet {
        title: "What’s New in 2.4"
        Component.onCompleted: open()

        QQC2.Label {
            wrapMode: Text.WordWrap
            textFormat: Text.MarkdownText
            text: "**Faster search.** Results now appear as you type.\n\n"
                + "**Tags.** Group notes with coloured tags and filter by them from the sidebar.\n\n"
                + "**Better printing.** Page breaks no longer split a heading from its text.\n\n"
                + "Thank you to the 14 people who contributed to this release."
        }
    }
}
