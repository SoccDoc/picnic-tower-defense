import QtQuick 

Item {
    id: root
    x: 10000
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
        x: -85
        y: -85
        width: 300
        height: 300
        color:  "#00FFFFFF"
        border.color: rangeColor
        radius: 180
    }
}
