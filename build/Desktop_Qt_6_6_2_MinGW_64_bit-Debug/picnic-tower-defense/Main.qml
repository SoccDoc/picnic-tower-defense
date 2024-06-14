import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Image {
        id: ant
        width: 100
        height: 100
        source: "qrc:/ant.png"
    }
}
