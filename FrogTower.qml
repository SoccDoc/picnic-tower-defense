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
}
