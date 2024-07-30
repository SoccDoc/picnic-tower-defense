import QtQuick
import QtQuick.Shapes

Item {
    id: root
    x: 10000 // Spawn off screen
    y: 10000
    z: 10 // Place frog on top of other objects

    property string rangeColor: "black"
    property bool attackIsOnCooldown: true

    Timer {
        id: attackCooldown
        interval: 200
        running: true
        onTriggered: attackIsOnCooldown = false
    }

    Rectangle {
        id: tongue
        x: -3 // Offset from frog image
        y: 30
        width: 10
        height: 50
        color: "red"
    }

    Image {
        id: frogImage
        x: -60 // Center frog image
        y: -60
        width: 120
        height: 120
        rotation: 180
        source: "qrc:/frog tower.png"
    }

    Rectangle {
        id: rangeIndicator
        x: -150 // Center range indicator
        y: -150
        width: 300 // Size of circle
        height: 300
        color:  "#00FFFFFF" // Make circle transparent
        border.color: rangeColor
        radius: 180 // Makes it a circle
    }

    function checkAnt(ant) {
        // Check if frog can attack
        if (attackIsOnCooldown)
            return;

        // Check if ant is in range of frog
        var distance = findDistance(ant)
        if (distance > rangeIndicator.radius)
            return;

        // Turn frog towards ant
        var xRelative = (ant.x+50) - root.x
        var yRelative = (ant.y+50) - root.y
        var slope = yRelative / xRelative
        var radiansAngle = Math.atan2(yRelative, xRelative)
        var degreesAngle = radiansAngle * (180 / Math.PI)
        root.rotation = degreesAngle - 90

        // Stick out tongue
        tongue.height = distance - 20

        // Attack the ant!
        ant.dealDamage(50);
        attackIsOnCooldown = true
        attackCooldown.start()
    }

    function findDistance(ant) {
        // Find distance from frog and ant
        var xDistance = Math.pow(root.x - (ant.x+50), 2)
        var yDistance = Math.pow(root.y - (ant.y+50), 2)
        var realDistance = Math.sqrt(xDistance + yDistance)
        return realDistance
    }
}
