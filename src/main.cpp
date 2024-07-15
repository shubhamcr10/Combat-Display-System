#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <ownship.h>
#include <iostream>
#include <QtDebug>
#include "subscriber.h"
#include "tracks.h"

int main(int argc, char *argv[])
{

    if (argc < 4 || atoi(argv[2]) == 0) {
        printf("usage: program [-h | --help] | ip port xml_path [<max_topics>]\n");
        return 0;
    }

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    std::string ip = argv[1];
    std::string port = argv[2];
    std::string xml_path = argv[3];
    uint32_t max_topics = (argc == 5) ? std::atoi(argv[5]) : UINT32_MAX;

    //Register the CourseSpeedDepth type using qRegisterMetaType
    qRegisterMetaType<CourseSpeedDepth>("CourseSpeedDepth");
    qRegisterMetaType<TrackType>("TrackType");

//    OwnShip ownShip(ip, port, max_topics);
    // Create an instance of the OwnShip class
    Tracks  tracks;
    OwnShip ownShip;

    // Create an instance of the Subscriber class
    Subscriber subscriber(ip, port, max_topics, xml_path);

    // Connect the static signal of the Subscriber class to a slot in the OwnShip class
    QObject::connect(&subscriber, &Subscriber::trackTopicReceived, &tracks, &Tracks::addOrUpdateTrack);
    QObject::connect(&subscriber, &Subscriber::qtStructTopicReceived, &ownShip, &OwnShip::onTopicReceived);

    // Start the Subscriber thread
    subscriber.start();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Tracks", &tracks);
    engine.rootContext()->setContextProperty("OwnShip", &ownShip);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
