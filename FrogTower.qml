import QtQuick 

Item {
    id: root

    function positionChanged(MouseEvent mouse) {
        Item.x = mouse
    }

    Image {
        id: frogImage
        width: 125
        height: 125
        source: "qrc:/frog tower.png"
    }
}
