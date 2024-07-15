#ifndef SUBSCRIBER_H
#define SUBSCRIBER_H

#include <uxr/client/client.h>
#include <string>
#include "TopicDefinitions.h"
#include <QThread>
#include <stdint.h>
#include <stdbool.h>
#include <vector>
#include "pugixml.hpp"

#define STREAM_HISTORY  8
#define BUFFER_SIZE     UXR_CONFIG_UDP_TRANSPORT_MTU * STREAM_HISTORY

struct topicDataReader {
    uint16_t topic_id;
    std::string topicname;
    std::string topic_xml;
    std::string datareader_xml;
};

struct subscriberRequest {
    uxrObjectId topic_id;
    uxrObjectId subscriber_id;
    uxrObjectId datareader_id;
    uint16_t topic_req;
    uint16_t subscriber_req;
    uint16_t datareader_req;
};

class Subscriber : public QThread {
    Q_OBJECT
public:
    Subscriber(const std::string& ip, const std::string& port, uint32_t max_topics, const std::string& xml_path, QObject *parent = nullptr);
    ~Subscriber();

    void run();

private:
    uxrUDPTransport transport;
    uxrSession session;
    uint32_t max_topics;
    bool validXml;

    std::string participant_xml = "";
    std::vector <topicDataReader> topicVector;
    std::vector <subscriberRequest> subscriberVector;
    pugi::xml_document doc;
   

    void validateXML(std::string filepath);

    // Define callback functions for each topic
    // static void onTrackTopic(uxrSession* session, uxrObjectId object_id, uint16_t request_id, uxrStreamId stream_id, struct ucdrBuffer* mb, uint16_t length, void* args);
    static void onTopic(uxrSession* session, uxrObjectId object_id, uint16_t request_id, uxrStreamId stream_id, struct ucdrBuffer* mb, uint16_t length, void* args);

    bool initializeSession(const std::string& ip, const std::string& port);

signals:
    void trackTopicReceived(const TrackType &topic);
    void qtStructTopicReceived(const CourseSpeedDepth &topic);
};

#endif // SUBSCRIBER_H
