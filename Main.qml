import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: mainWindow
    visible: true
    title: qsTr("Picnic Tower Defense")
    visibility: "FullScreen"

    property int score: 0
    property int lives: 20
    property int money: 100

    property bool gameOver: false

    property int frogTowerCost: 50

    property var towers: [] // list of all purchased towers
    property var ants: [] // list of all currently alive ant enemies

    readonly property int menuColumnWidth: 150
    readonly property double frameRate: 1000/60 // 60fps

    // Populate scalers so the ant still follows the path on different resolutions
    readonly property int mainWindowDefaultX: 1920 - menuColumnWidth
    readonly property int mainWindowDefaultY: 1080
    readonly property double mainWindowScalerX: (mainWindow.width - menuColumnWidth) / mainWindowDefaultX
    readonly property double mainWindowScalerY: mainWindow.height / mainWindowDefaultY

    // Represents the playing field
    Rectangle {
        id: background
        width: mainWindow.width - menuColumnWidth
        height: mainWindow.height
    }

    // Organizes the buttons and playing field
    GridLayout {
        anchors.fill: parent
        rows: 1
        columns: 2

        // Background for the window
        Item {
            id: backgroundImage
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                visible: true

                width: background.width
                height: background.height

                source: "qrc:/background.png"
            }
        }

        ColumnLayout {
            anchors.rightMargin: mainWindow.width
            anchors.leftMargin: background.width

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
                id: waveLabel
                text: "Wave: " + antSpawner.currentWave

                width: 125
                height: 25

                Layout.preferredWidth: width
                Layout.preferredHeight: height
            }

            Label {
                id: scoreLabel
                text: "Score: " + mainWindow.score

                width: 125
                height: 25

                Layout.preferredWidth: width
                Layout.preferredHeight: height
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
        anchors.fill: background
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
            towers.push(currentFrogTower)
            currentFrogTower.rangeColor = "#00FFFFFF"
            currentFrogTower = undefined
        }
    }

    // Occasionally spawns ants. Spawns more as time passes
    EnemySpawner {
        id: antSpawner

        // Spawns one ant to run down the path
        onSpawnEnemy: {
            var component = Qt.createComponent("Ant.qml")
            if (component.status === Component.Ready) {
                // Setup ant initial values
                var ant = component.createObject(mainWindow)
                ant.xPathScaler = mainWindowScalerX
                ant.yPathScaler = mainWindowScalerY
                ant.onAntDied.connect(deadAnt)
                ants.push(ant)
            }
            else if (component.status === Component.Error) {
                // Ant not ready, print why
                console.log(component.errorString())
            }
        }
    }

    // Updates the game every frame
    Timer {
        id: updateTimer
        interval: frameRate
        running: true
        onTriggered: update()
    }

    function update() {
        // Check if all ants are dead
        if (ants.length == 0)
            antSpawner.calculateEnemiesPerWave()

        // If the player is out of lives, end game
        if (lives <= 0)
            gameOver = true

        // Attempt to fire all towers
        fireAllTowers()

        // Start time to next frame
        updateTimer.start()
    }

    function fireAllTowers() {
        // Check if any ant is in range of any frog tower
        for (var i = 0; i < towers.length; i++) {
            for (var j = 0; j < ants.length; j++) {
                var currentFrog = towers[i]
                var currentAnt = ants[j]

                // Adjust the ants x and y then send to tower
                var antImageOffset = currentAnt.imageSize / 2
                var adjustedAntX = currentAnt.x + antImageOffset
                var adjustedAntY = currentAnt.y + antImageOffset
                var attackIsSuccessful = currentFrog.tryToAttackAnt(adjustedAntX, adjustedAntY);

                // If frog lands an attack, deal damage
                if (attackIsSuccessful)
                    currentAnt.dealDamage(currentFrog.attackDamage)
            }
        }
    }

    // Called when an ant dies
    function deadAnt(ant: Ant) {
        // If ant reached end of path, take a life.
        if (ant.reachedEnd)
            mainWindow.lives -= ant.strength
        // If not, increase score if game isn't over
        else if (!gameOver)
            mainWindow.score += ant.bounty

        // Give player money regardless of if ant reached the end
        mainWindow.money += ant.bounty

        // Remove the ant
        const index = ants.indexOf(ant);
        if (index > -1)
          ants.splice(index, 1);
        ant.kill()
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
