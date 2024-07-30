import QtQuick

Item {
    id: root
    property int baseEnemies: 8
    property double enemySpawnIntervalMilliseconds: 500
    property double timeBetweenWaves: 5
    property double difficultyScalingFactor: 0.75

    property int currentWave: 1
    property bool allEnemiesKilled: true
    property int enemiesLeftToSpawn: 0

    signal spawnEnemy()

    Timer {
        id: enemyDelay
        interval: enemySpawnIntervalMilliseconds
        running: true
        onTriggered: spawnEnemy()
    }

    function calculateEnemiesPerWave() {
        var waveScaler = Math.pow(currentWav, difficultyScalingFactor)
        enemiesLeftToSpawn = baseEnemies * waveScaler
    }
}
