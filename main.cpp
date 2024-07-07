#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "frogtower.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<FrogTower>("Tower", 1, 0, "FrogTower");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/picnic-tower-defense/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
