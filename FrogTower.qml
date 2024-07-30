import QtQuick
import QtQuick.Shapes

Item {
    id: root
    x: 10000 // Spawn off screen
    y: 10000
    z: 10 // Place frog on top of other objects

    property string rangeColor: "black"
    property bool attackIsOnCooldown: true
    property int attackDamage: 50

    Timer {
        id: attackCooldown
        interval: 200
        running: true
        onTriggered: attackIsOnCooldown = false
    }

    Rectangle {
        id: tongue
        width: 10
        x: -(width / 2) // Center frog tongue
        height: 50
        color: "red"
    }

    Image {
        id: frogImage
        width: 120
        height: 120
        x: -(width / 2) // Center frog image
        y: -(height / 2)

        rotation: 180
        source: "qrc:/frog tower.png"
    }

    Rectangle {
        id: rangeIndicator
        width: 300 // Size of circle
        height: 300
        x: -(width / 2) // Center range indicator
        y: -(height / 2)

        color: "#00FFFFFF" // Make circle transparent
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
        root.rotation = degreesAngle - 90 // angle offset

        // Stick out tongue
        tongue.height = distance

        // Attack the ant!
        ant.dealDamage(attackDamage);
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
