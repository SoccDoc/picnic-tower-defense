import QtQuick

Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Picnic Tower Defense")

    // Background for the window
    Rectangle {
        color: "green"
        width: mainWindow.width
        height: mainWindow.height
    }

    Image {
        id: ant
        visible: true
        width: 100
        height: 100
        source: "qrc:/ant.png"
    }

    // Animation for ant to move along path
    PathAnimation {
        id: antPath
        running: true
        duration: 3000
        loops: 1
        onRunningChanged: triggerChangeProc()

        target: ant
        orientation: PathAnimation.TopFirst
        anchorPoint: Qt.point(ant.width/2, ant.height/2)

        path: Path {
            startX: 100; startY: 100

           PathCurve { x: 100; y: 100}
           PathCurve { x: 400; y: 500}
        }
    }

    // Called when ant reaches end of path
    function triggerChangeProc() {
        // Check if the ant is still moving
        if (antPath.running === true)
            return

        // It is not, remove the ant
        ant.visible = false
    }

}
