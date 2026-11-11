// Prints the live values of Kirigami.Units and every Kirigami.Theme colour
// role, for each colour set, as one JSON line prefixed with "THEME-JSON".
import QtQuick
import org.kde.kirigami as Kirigami

Item {
    id: root

    readonly property var setNames: ["View", "Window", "Button", "Selection", "Tooltip", "Complementary", "Header"]
    readonly property var roles: [
        "textColor", "disabledTextColor", "highlightedTextColor", "activeTextColor",
        "linkColor", "visitedLinkColor", "negativeTextColor", "neutralTextColor", "positiveTextColor",
        "backgroundColor", "alternateBackgroundColor", "highlightColor", "activeBackgroundColor",
        "linkBackgroundColor", "negativeBackgroundColor", "neutralBackgroundColor", "positiveBackgroundColor",
        "hoverColor", "focusColor"
    ]

    Repeater {
        id: sets
        model: [Kirigami.Theme.View, Kirigami.Theme.Window, Kirigami.Theme.Button, Kirigami.Theme.Selection,
                Kirigami.Theme.Tooltip, Kirigami.Theme.Complementary, Kirigami.Theme.Header]
        Item {
            Kirigami.Theme.colorSet: modelData
            Kirigami.Theme.inherit: false
        }
    }

    Timer {
        interval: 300
        running: true
        onTriggered: {
            const out = { units: {}, iconSizes: {}, sets: {} }
            for (const k of ["gridUnit", "smallSpacing", "mediumSpacing", "largeSpacing", "cornerRadius",
                             "veryShortDuration", "shortDuration", "longDuration", "veryLongDuration",
                             "humanMoment", "toolTipDelay"]) {
                out.units[k] = Kirigami.Units[k]
            }
            for (const k of ["small", "smallMedium", "medium", "large", "huge", "enormous"]) {
                out.iconSizes[k] = Kirigami.Units.iconSizes[k]
            }
            for (let i = 0; i < sets.count; i++) {
                const colors = {}
                for (const role of root.roles) {
                    colors[role] = String(sets.itemAt(i).Kirigami.Theme[role])
                }
                out.sets[root.setNames[i]] = colors
            }
            console.warn("THEME-JSON" + JSON.stringify(out))
            Qt.quit()
        }
    }
}
