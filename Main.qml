import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: mainWindow
    visible: true
    title: qsTr("Picnic Tower Defense")
    visibility: "FullScreen"

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

                width: mainWindow.width - 200
                height: mainWindow.height

                source: "qrc:/background.png"
            }
        }

        ColumnLayout {
            anchors.rightMargin: mainWindow.width
            anchors.leftMargin: mainWindow.width - 200

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

            // Button for buying frog tower
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
                onClicked: spawnFrogTower()
            }
        }
    }

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
            onRunningChanged: triggerChangeProc()

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

    // Called when ant reaches end of path
    function triggerChangeProc() {
        // Check if the ant is still moving
        if (antPath.running === true)
            return

        // It is not, remove the ant
        antImage.visible = false

        // Subtract a life
    }

    // Called when player buys a frog tower
    function spawnFrogTower() {

    }

}
