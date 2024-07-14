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
            currentFrogTower.rangeColor = "#00FFFFFF"
            currentFrogTower = undefined
        }
    }

    // I can't believe this actually works
    Ant {
        onAntDied: {
            money += 50
            lives--
        }
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
