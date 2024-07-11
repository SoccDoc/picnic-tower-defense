import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: mainWindow
    visible: true
    title: qsTr("Picnic Tower Defense")
    visibility: "FullScreen"

    property int money: 200
    property int lives: 20
    property int frogTowerCost: 50

    // Represents the playing field
    Rectangle {
        id: backgroundOutline
        width:  mainWindow.width - 150
        height: mainWindow.height
    }

    // Organizes the buttons and playing field
    GridLayout {
        anchors.fill: parent
        rows: 1
        columns: 2

        // Background for the window
        Item {
            id: background
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                visible: true

                width: backgroundOutline.width
                height: backgroundOutline.height

                source: "qrc:/background.png"
            }
        }

        ColumnLayout {
            anchors.rightMargin: mainWindow.width
            anchors.leftMargin: mainWindow.width - 150

            // Button to close game
            Button {
                id: closeWindowButton

                width: 125
                height: 25

                Layout.preferredWidth: width
                Layout.preferredHeight: height

                text: "Close Application"
                onClicked: mainWindow.close()
            }

            Label {
                id: livesLabel
                text: "Lives: " + mainWindow.lives

                width: 125
                height: 25

                Layout.preferredWidth: width
                Layout.preferredHeight: height
            }

            Label {
                id: moneyLabel
                text: "Gold: " + mainWindow.money

                width: 125
                height: 25

                Layout.preferredWidth: width
                Layout.preferredHeight: height
            }

            // Button for buying frog towers
            Button {
                id: frogTowerButton
                width: 125
                height: 125

                Layout.preferredWidth: width
                Layout.preferredHeight: height

                icon.source: "qrc:/frog tower.png"
                icon.color: "transparent"
                icon.width: width
                icon.height: height

                padding: 0
                onClicked: purchaseFrogTower()
            }
        }
    }

    // Tracks the mouse when it is in the playing field
    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: backgroundOutline
        property var currentFrogTower

        // Make the tower follow the users mouse
        onPositionChanged: {
            if (currentFrogTower !== undefined) {
                currentFrogTower.x = mouseArea.mouseX
                currentFrogTower.y = mouseArea.mouseY
            }
        }

        // When clicked, unbind the tower so it stays where the user clicked
        onClicked: {
            currentFrogTower = undefined
        }
    }

    // A sample ant components (to be extracted)
    Item {
        id: ant

        Image {
            id: antImage
            visible: true
            width: 50
            height: 50
            source: "qrc:/ant.png"
        }

        // Animation for ant to move along path
        PathAnimation {
            id: antPath
            running: true
            duration: 10000
            loops: 1
            onRunningChanged: checkAntProgress()

            target: antImage
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
    }

    // Called when ant reaches end of a path segment
    function checkAntProgress() {
        // Check if the ant is still moving
        if (antPath.running === true)
            return

        // It is not then it has reached the picnic basket
        antImage.visible = false // remove the ant
        mainWindow.money += 50 // give money
        mainWindow.lives-- // subtract a life
    }

    // Called when player clicks on the frog tower button
    function purchaseFrogTower() {
        // Check if player has enough money
        if (money < frogTowerCost)
            return

        // Take money
        money -= frogTowerCost;

        // Create a frog tower
        var component = Qt.createComponent("FrogTower.qml")
        if (component.status === Component.Ready) {
            // If the frog tower is ready, bind it to the mouse area
            var frogTower = component.createObject(mainWindow)
            mouseArea.currentFrogTower = frogTower
        }
        else if (component.status === Component.Error) {
            // Frog tower is not ready, print why
            console.log(component.errorString())
        }
    }

}
