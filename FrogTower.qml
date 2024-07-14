import QtQuick

Item {
    id: root
    x: 10000 // Spawn off screen
    y: 10000
    property string rangeColor: "black"

    Image {
        id: frogImage
        width: 125
        height: 125
        source: "qrc:/frog tower.png"
    }

    Rectangle {
        id: range
        x: -85 // Offset from frog tower
        y: -85
        width: 300 // Size of circle
        height: 300
        color:  "#00FFFFFF" // Transparent
        border.color: rangeColor
        radius: 180 // Makes it a circle
    }

    function checkAnt(ant) {
        // Check if ant is in range of frog
        if (!antIsInRange(ant))
            return;

        // It is, so deal damage
        ant.dealDamage(50);
    }

    function antIsInRange(ant) {
        // Find distance from frog and ant
        var xDistance = Math.pow(root.x - ant.x, 2)
        var yDistance = Math.pow(root.y - ant.y, 2)
        var realDistance = Math.sqrt(xDistance + yDistance)

        // Check if it is in frog's range
        if (realDistance < range.radius)
            return true;
        return false;
    }
}
