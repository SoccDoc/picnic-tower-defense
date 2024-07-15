import QtQuick

Item {
    id: root
    x: 10000 // Spawn off screen
    y: 10000

    property string rangeColor: "black"
    property bool attackIsOnCooldown: true

    Timer {
        id: attackCooldown
        interval: 1000
        running: true
        onTriggered: attackIsOnCooldown = false
    }

    Rectangle {
        id: tongue
        x: -3 // Offset from frog tower
        y: 30
        width: 10
        height: 50
        color: "red"
    }

    Image {
        id: frogImage
        x: -60
        y: -60
        width: 125
        height: 125
        rotation: 180
        source: "qrc:/frog tower.png"
    }

    Rectangle {
        id: range
        x: -145 // Offset from frog tower
        y: -145
        width: 300 // Size of circle
        height: 300
        color:  "#00FFFFFF" // Transparent
        border.color: rangeColor
        radius: 180 // Makes it a circle
    }

    function checkAnt(ant) {
        // Check if frog can attack
        if (attackIsOnCooldown)
            return;

        // Check if ant is in range of frog
        var distance = antDistance(ant)
        if (distance > range.radius)
            return;

        // Turn frog towards ant
        var xAbsolute = ant.x - x
        var yAbsolute = ant.y - y
        var radiansAngle = Math.atan2(yAbsolute, xAbsolute)
        var degreesAngle = radiansAngle * (180 / Math.PI)
        root.rotation = degreesAngle

        console.log(degreesAngle)

        // Stick out tongue
        tongue.height = distance

        // Attack the ant!
        //ant.dealDamage(50);
        attackIsOnCooldown = true
        attackCooldown.start()
    }

    function antDistance(ant) {
        // Find distance from frog and ant
        var xDistance = Math.pow(root.x - ant.x, 2)
        var yDistance = Math.pow(root.y - ant.y, 2)
        var realDistance = Math.sqrt(xDistance + yDistance)
        return realDistance
    }
}
