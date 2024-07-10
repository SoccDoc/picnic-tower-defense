import QtQuick 

Item {
    id: root
    x: mouseArea.mouseXChanged()
    y: mouseArea.mouseYChanged()

    Image {
        id: frogImage
        width: 125
        height: 125
        source: "qrc:/frog tower.png"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root.parent

        onClicked: {
            root.x = root.x
            root.y = root.y
            console.log("clicked tower")
        }
    }
}
