import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    visible: true
    width: 800
    height: 480

    Loader {
        id: loader

        anchors {
            fill: parent
        }

        source: "NetworkInfo.qml"

        Item {
            anchors.centerIn: parent
            width: txt.paintedWidth; height: txt.paintedHeight
            visible: parent.status === Loader.Error
            Text {
                id: txt
                width: loader.width
                wrapMode: Text.WordWrap
                text: "Failed to load " + loader.source
            }
        }
    }
}
