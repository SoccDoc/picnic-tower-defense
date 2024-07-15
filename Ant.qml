import QtQuick

Item {
    id: root
    property int health: 100
    property bool reachedEnd: false

    signal antDied()

    Image {
        id: antImage
        visible: true
        width: 100
        height: 100
        source: "qrc:/ant.png"
    }

    // Animation for ant to move along path
    PathAnimation {
        id: antPath
        running: true
        duration: 100000
        loops: 1
        onRunningChanged: checkAntProgress()

        target: root
        orientation: PathAnimation.TopFirst
        anchorPoint: Qt.point(antImage.width/2, antImage.height/2)

        // The path to the picnic basket
        path: Path {
            startX: 0; startY: 190

           PathCurve { x: 300; y: 190}
           PathCurve { x: 300; y: 470}
           PathCurve { x: 540; y: 470}
           PathCurve { x: 540; y: 650}
           PathCurve { x: 350; y: 650}
           PathCurve { x: 350; y: 870}
           PathCurve { x: 1000; y: 870}
           PathCurve { x: 1000; y: 580}
           PathCurve { x: 820; y: 580}
           PathCurve { x: 820; y: 330}
           PathCurve { x: 1430; y: 330}
           PathCurve { x: 1430; y: 730}
           PathCurve { x: 2000; y: 730}
        }
    }


    // Called when ant reaches end of a path segment
    function checkAntProgress() {
        // Check if the ant is still moving
        if (antPath.running === true)
            return

        // It has reached the picnic basket
        root.reachedEnd = true
        root.antDied()
        root.destroy()
    }

    function dealDamage(damage) {
        // Take damage
        health -= damage;

        // If health is below zero, kill the ant
        if (health < 0) {
            root.antDied()
            root.destroy()
        }
    }
}
