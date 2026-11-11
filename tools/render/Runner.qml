// Renders one example QML file to a PNG and quits.
// Usage: qml6 Runner.qml -- <example.qml> <out.png>
//
// The example's root may be an Item (rendered at its implicit size on a
// Window-coloured backdrop) or a Window such as Kirigami.ApplicationWindow
// (its whole content, including open dialogs and drawers, is captured).
import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Window {
    id: host

    readonly property var args: Qt.application.arguments
    readonly property string source: args[args.length - 2]
    readonly property string output: args[args.length - 1]
    property var target: null
    property var window: null

    Component {
        id: stageComponent
        Item {}
    }

    // A window's own contentItem cannot be grabbed from QML, so everything in
    // it (page content plus the overlay layer holding dialogs and drawers) is
    // moved into a stage item that can.
    function stageWindow() {
        // The root item is the parent of contentItem, header, drawers and overlay.
        const content = window.QQC2.Overlay.overlay.parent
        const stage = stageComponent.createObject(content, { width: content.width, height: content.height })
        for (const child of Array.from(content.children)) {
            if (child !== stage) {
                child.parent = stage
            }
        }
        return stage
    }

    visible: false
    width: frame.width
    height: frame.height

    Rectangle {
        id: frame
        Kirigami.Theme.colorSet: Kirigami.Theme.Window
        Kirigami.Theme.inherit: false
        color: Kirigami.Theme.backgroundColor
        width: 100
        height: 100
    }

    function fail(code, message) {
        console.error("RENDER-ERROR", message)
        Qt.exit(code)
    }

    Component.onCompleted: {
        const component = Qt.createComponent("file://" + source)
        if (component.status !== Component.Ready) {
            fail(2, component.errorString())
            return
        }
        const isWindow = source.endsWith(".window.qml")
        const object = component.createObject(isWindow ? null : frame)
        if (!object) {
            fail(2, component.errorString())
            return
        }
        if (isWindow) {
            object.visible = true
            window = object
        } else {
            const pad = Kirigami.Units.gridUnit
            object.x = pad
            object.y = pad
            frame.width = Qt.binding(() => object.width + pad * 2)
            frame.height = Qt.binding(() => object.height + pad * 2)
            host.visible = true
            target = frame
        }
        shutter.start()
    }

    Timer {
        id: shutter
        // Long enough for icons to load and open/close animations to settle.
        interval: 1500
        onTriggered: (host.window ? host.stageWindow() : host.target).grabToImage(result => {
            if (result.saveToFile(host.output)) {
                Qt.exit(0)
            } else {
                host.fail(3, "could not save " + host.output)
            }
        })
    }
}
