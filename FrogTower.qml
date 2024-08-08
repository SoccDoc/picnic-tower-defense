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
        interval: 1000
        running: true
        onTriggered: attackIsOnCooldown = false
    }

    Timer {
        id: retractTongue
        interval: attackCooldown.interval / 2
        running: false
        onTriggered: tongue.height = 50
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

    /*!
        \fn FrogTower::checkAnt(antX, antY)

        Checks if an ant at the given x and y values is in range of this frog tower.
        Returns true if attack is successful, false otherwise
    */
    function tryToAttackAnt(antX, antY) {
        // Check if frog can attack
        if (attackIsOnCooldown)
            return false;

        // Check if ant is in range of frog
        var distance = findDistance(antX, antY)
        if (distance > rangeIndicator.radius)
            return false;

        // Turn frog towards ant
        var xRelative = antX - root.x
        var yRelative = antY - root.y
        var radiansAngle = Math.atan2(yRelative, xRelative)
        var degreesAngle = radiansAngle * (180 / Math.PI)
        root.rotation = degreesAngle - 90 // angle offset

        // Stick out tongue
        tongue.height = distance

        // Attack the ant!
        attackIsOnCooldown = true
        attackCooldown.start()
        retractTongue.start()
        return true;
    }

    /*!
        \fn FrogTower::findDistance(otherX, otherY)

        Finds the distance between this frog tower and the given point
    */
    function findDistance(otherX, otherY) {
        // Find distance from frog and ant
        var xDistance = Math.pow(root.x - otherX, 2)
        var yDistance = Math.pow(root.y - otherY, 2)
        var realDistance = Math.sqrt(xDistance + yDistance)
        return realDistance
    }
}
