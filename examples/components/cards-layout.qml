import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Item {
    implicitWidth: Kirigami.Units.gridUnit * 34
    implicitHeight: layout.implicitHeight + Kirigami.Units.largeSpacing * 2

    Kirigami.CardsLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing

        Repeater {
            model: [
                { title: "Storage", text: "128 GB of 512 GB used", icon: "drive-harddisk" },
                { title: "Battery", text: "82%, about 6 hours left", icon: "battery-080" },
                { title: "Network", text: "Connected to Home Wi-Fi", icon: "network-wireless" },
                { title: "Updates", text: "The system is up to date", icon: "system-software-update" }
            ]

            Kirigami.AbstractCard {
                required property var modelData

                contentItem: RowLayout {
                    spacing: Kirigami.Units.largeSpacing

                    Kirigami.Icon {
                        source: modelData.icon
                        implicitWidth: Kirigami.Units.iconSizes.medium
                        implicitHeight: Kirigami.Units.iconSizes.medium
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 0

                        Kirigami.Heading {
                            Layout.fillWidth: true
                            text: modelData.title
                            level: 4
                            elide: Text.ElideRight
                        }
                        QQC2.Label {
                            Layout.fillWidth: true
                            text: modelData.text
                            opacity: 0.75
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
    }
}
