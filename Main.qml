import QtQuick

Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Picnic Tower Defense")

    Rectangle {
        color: "green"
        width: mainWindow.width
        height: mainWindow.height
    }

    Image {
        id: ant
        width: 100
        height: 100
        source: "qrc:/ant.png"
    }

    PathAnimation {
        id: antPath
        running: true
        duration: 3000
        loops: 10

        target: ant
        orientation: PathAnimation.TopFirst
        anchorPoint: Qt.point(ant.width/2, ant.height/2)

        path: Path {
            startX: 100; startY: 100

           PathCurve { x: 100; y: 100}
           PathCurve { x: 400; y: 500}
        }
    }
}

