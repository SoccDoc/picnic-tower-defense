import QtQuick

Item {
    id: root
    property int baseEnemies: 3
    property double difficultyScalingFactor: 0.75
    property double baseEnemySpawnIntervalMilliseconds: 1000
    property double enemySpawnIntervalMilliseconds: 1000

    property int currentWave: 0
    property int waveDelayMilliseconds: 5000
    property bool nextWaveReady: true
    property int enemiesLeftToSpawn: 0

    signal spawnEnemy()

    Timer {
        id: enemyDelay
        interval: enemySpawnIntervalMilliseconds
        running: false
        onTriggered: spawnEnemyDelay()
    }

    Timer {
        id: waveDelay
        interval: waveDelayMilliseconds
        running: false
        onTriggered: nextWaveReady = true
    }

    // Calculates how many enemies need to be in the next wave
    function calculateEnemiesPerWave() {
        // Check if time has passed for this wave to complete
        if (nextWaveReady) {
            currentWave++
            var waveScaler = Math.pow(currentWave, difficultyScalingFactor)
            enemiesLeftToSpawn = baseEnemies * waveScaler
            enemySpawnIntervalMilliseconds = baseEnemySpawnIntervalMilliseconds - waveScaler
        }

        // Give time before the next wave
        nextWaveReady = false

        // Start spawning enemies
        enemyDelay.start()
        waveDelay.start()
    }

    // Spawns an enemy and resets delay if more need to be spawned
    function spawnEnemyDelay() {
        // Spawn an enemy and remove them from the count
        enemiesLeftToSpawn--
        spawnEnemy()

        // Reset delay if there are more enemies to spawn
        if (enemiesLeftToSpawn > 0)
            enemyDelay.start()
    }
}
