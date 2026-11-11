import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.kirigami.delegates as KD

// Rows that can be ticked: the whole row is the click target.
QQC2.ScrollView {
    width: Kirigami.Units.gridUnit * 20
    height: Kirigami.Units.gridUnit * 9

    Kirigami.Theme.colorSet: Kirigami.Theme.View
    Kirigami.Theme.inherit: false
    background: Rectangle {
        color: Kirigami.Theme.backgroundColor
    }

    ListView {
        currentIndex: -1

        model: ListModel {
            ListElement { glyph: "folder-documents"; name: "Documents"; detail: "1,204 files, 3.1 GB"; ticked: true }
            ListElement { glyph: "folder-pictures"; name: "Pictures"; detail: "8,930 files, 41 GB"; ticked: true }
            ListElement { glyph: "folder-download"; name: "Downloads"; detail: "212 files, 9.8 GB"; ticked: false }
        }

        delegate: KD.CheckSubtitleDelegate {
            required property string name
            required property string detail
            required property bool ticked
            required property string glyph

            width: ListView.view.width
            text: name
            subtitle: detail
            icon.name: glyph
            checked: ticked
        }
    }
}
