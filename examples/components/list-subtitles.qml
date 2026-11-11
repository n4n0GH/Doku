import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.kirigami.delegates as KD

// Two lines per item: a title and a quieter subtitle.
QQC2.ScrollView {
    width: Kirigami.Units.gridUnit * 20
    height: Kirigami.Units.gridUnit * 11

    Kirigami.Theme.colorSet: Kirigami.Theme.View
    Kirigami.Theme.inherit: false
    background: Rectangle {
        color: Kirigami.Theme.backgroundColor
    }

    ListView {
        currentIndex: 0

        model: ListModel {
            ListElement { name: "Home Wi-Fi"; detail: "Connected, excellent signal"; glyph: "network-wireless" }
            ListElement { name: "Office"; detail: "Saved, out of range"; glyph: "network-wireless" }
            ListElement { name: "Wired connection"; detail: "Cable unplugged"; glyph: "network-wired" }
            ListElement { name: "Work VPN"; detail: "Not connected"; glyph: "network-vpn" }
        }

        delegate: KD.SubtitleDelegate {
            required property string name
            required property string detail
            required property string glyph

            width: ListView.view.width
            text: name
            subtitle: detail
            icon.name: glyph
            highlighted: ListView.isCurrentItem
        }
    }
}
