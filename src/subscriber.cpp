#include "subscriber.h"
#include <iostream>
#include <stdio.h>
#include <fstream>
#include <sstream>
#include <map>
#include "pugixml.hpp"
#include "Tool.h"
#include <time.h>

#define REQ_COUNT 3
#define PARTICIPANT_COUNT 1
#define START_IDX 0
#define OWNSHIP_DATA_RECEIVED 2
#define TRACK_RECEIVED 1

const char* subscriber_xml = "";


bool CourseSpeedDepth_deserialize_topic(ucdrBuffer* reader, CourseSpeedDepth* topic)
{
    bool success = true;

    success &= ucdr_deserialize_float(reader, &topic->course);

    success &= ucdr_deserialize_float(reader, &topic->speed);

    success &= ucdr_deserialize_float(reader, &topic->depth);

    return success && !reader->error;
}

bool TrackType_deserialize_topic(ucdrBuffer* reader, TrackType* topic)
{
    bool success = true;

        success &= ucdr_deserialize_array_char(reader, topic->shipID, sizeof(topic->shipID) / sizeof(char));

        success &= ucdr_deserialize_float(reader, &topic->range);

        success &= ucdr_deserialize_float(reader, &topic->bearing);

        success &= ucdr_deserialize_float(reader, &topic->sensor_ID);

        success &= ucdr_deserialize_float(reader, &topic->speed);

        success &= ucdr_deserialize_double(reader, &topic->sensor_timestamp);

    return success && !reader->error;
}

Subscriber::Subscriber(const std::string& ip, const std::string& port, uint32_t max_topics, const std::string& xml_path, QObject *parent) : max_topics(max_topics), QThread(parent), validXml(false) {
    
    // pugi::xml_document doc;
    // pugi::xml_parse_result result = doc.load_file(xml_path.c_str());

    validateXML(xml_path);
    if (!validXml) {
        // If XML is not valid, print an error message and return from the constructor
        std::cerr << "Error: XML is not valid." << std::endl;
        return;
    }

    static std::string ddsStartTag = "<dds>";
    static std::string ddsEndTag = "</dds>";
    static std::string participantStartTag = "<participant>";
    static std::string participantEndTag = "</participant>";
    static std::string rtpsStartTag = "<rtps>";
    static std::string rtpsEndTag = "</rtps>";
    static std::string topicStartTag = "<topic>";
    static std::string topicEndTag = "</topic>";
    static std::string topicNameStartTag = "<name>";
    static std::string topicNameEndTag = "</name>";
    static std::string topicDataTypeStartTag = "<dataType>";
    static std::string topicDataTypeEndTag = "</dataType>";
    static std::string topicKindStartTag = "<kind>";
    static std::string topicKindEndTag = "</kind>";
    static std::string dataReaderStartTag = "<data_reader>";
    static std::string dataReaderEndTag = "</data_reader>";

    std::string name = "";
    std::string dataType = "";
    std::string kind = "";
    std::string topicIdStr = "";
    std::string topicname= "";

    std::string topic_xml = "";
    std::string data_reader_xml = "";

     //condition if all tags exist then move inside
    
     pugi::xml_node tool = doc.child("DDS").child("participant").child("rtps");
     name += tool.child_value("name");

     participant_xml =  ddsStartTag;
     participant_xml += participantStartTag; 
     participant_xml += rtpsStartTag;
     participant_xml += name;
     participant_xml += rtpsEndTag;
     participant_xml += participantEndTag;
     participant_xml += ddsEndTag;
     std::cout<<"participant_xml: "<<participant_xml<<std::endl;
     name = "";

    for (pugi::xml_node tool: doc.child("DDS").child("Topics").children("Topic"))
    {
        name = tool.child_value("name");
        dataType = tool.child_value("dataType");
        kind = tool.child_value("kind");
        topicIdStr = tool.child_value("topicId");
        topicname = tool.child_value("topicname");
        if (name.empty())
        {
           std::cout << "missing name tag: Exiting" << "\n";
              return ;
        }
        
        if (dataType.empty())
        {
           std::cout << "missing dataType tag: Exiting" << "\n";
              return ;
        }

        if (kind.empty())
        {
            std::cout << "missing kind tag: Exiting" << "\n";
              return ;
        }

        if (topicIdStr.empty())
        {
            std::cout << "missing topicId tag: Exiting" << "\n";
              return ;
        }

    
        topic_xml = ddsStartTag;
        topic_xml += topicStartTag;
        topic_xml += topicNameStartTag;
        topic_xml += name;
        topic_xml += topicNameEndTag;
        topic_xml += topicDataTypeStartTag;
        topic_xml += dataType;
        topic_xml += topicDataTypeEndTag;
        topic_xml += topicEndTag;
        topic_xml += ddsEndTag;

        data_reader_xml = ddsStartTag;
        data_reader_xml += dataReaderStartTag;
        data_reader_xml += topicStartTag;
        data_reader_xml += topicKindStartTag;
        data_reader_xml += kind;
        data_reader_xml += topicKindEndTag;
        data_reader_xml += topicNameStartTag;
        data_reader_xml += name;
        data_reader_xml += topicNameEndTag;
        data_reader_xml += topicDataTypeStartTag;
        data_reader_xml += dataType;
        data_reader_xml += topicDataTypeEndTag;
        data_reader_xml += topicEndTag;
        data_reader_xml += dataReaderEndTag;
        data_reader_xml += ddsEndTag;
        //            std::cout << "topic_xml:" << topic_xml.c_str() << "\n";
        //            std::cout << "data_reader_xml:" << data_reader_xml << "\n";

        topicDataReader topic_data;
        
        topic_data.topic_id = std::atoi(topicIdStr.c_str());
        topic_data.topicname = topicname;
        // std::cout<<"topic_data.object_id: "<<topic_data.object_id<<std::endl;
        topic_data.topic_xml = topic_xml;
        topic_data.datareader_xml = data_reader_xml;

        topicVector.push_back(topic_data);
        name = "";
        dataType = "";
        kind = "";
        topicIdStr = "";
        data_reader_xml = "";
        topic_xml = "";
        topicname = "";

    }

    if (!initializeSession(ip, port)) {
        std::cerr<<"Error: Session not initialized "<<std::endl;
    }
}

void Subscriber::validateXML(std::string filepath){
    pugi::xml_parse_result result = doc.load_file(filepath.c_str());
    
          if (!result){
           std::cout << "File read error " << "\n";
           return;
          }
          else{
            // Check if the root node is <DDS>
            pugi::xml_node ddsNode = doc.child("DDS");
            if (!ddsNode) {
                 std::cout << "DDS tag missing " << "\n";
                return ;
            }

            // Check if all necessary child nodes exist
            pugi::xml_node participantNode = ddsNode.child("participant");
            if (!participantNode) {
                std::cout << "participant tag missing " << "\n";
                return ;
            }

            pugi::xml_node rtpsNode = participantNode.child("rtps");
            if (!rtpsNode) {
                std::cout << "rtps tag missing " << "\n";
                return ;
            }

            pugi::xml_node topicsNode = ddsNode.child("Topics");
            if (!topicsNode) {
                std::cout << "topics tag missing " << "\n";
                return ;
            }

            if (!topicsNode.child("Topic")) {
                std::cout << "topic tag missing " << "\n";
                return ;
            }

     validXml = true; // All checks passed
          }
    }
  
Subscriber::~Subscriber() {
    uxr_delete_session(&session);
    this->quit();
    this->wait();
}

void Subscriber::run() {

    // Streams
    uint8_t output_reliable_stream_buffer[BUFFER_SIZE];
    uxrStreamId reliable_out = uxr_create_output_reliable_stream(&session, output_reliable_stream_buffer, BUFFER_SIZE, STREAM_HISTORY);

    uint8_t input_reliable_stream_buffer[BUFFER_SIZE];
    uxrStreamId reliable_in = uxr_create_input_reliable_stream(&session, input_reliable_stream_buffer, BUFFER_SIZE, STREAM_HISTORY);

    // Create entities
    uxrObjectId participant_id = uxr_object_id(0x01, UXR_PARTICIPANT_ID);
    uint16_t participant_req = uxr_buffer_create_participant_xml(&session, reliable_out, participant_id, 0, participant_xml.c_str(), UXR_REPLACE);

    uint16_t request_size = REQ_COUNT*topicVector.size()+PARTICIPANT_COUNT;
    uint16_t requests[request_size];
    uint16_t  start = START_IDX;
    requests[start++] = participant_req; //participant_req assigned at index 0
    
    for (size_t i = 0; i < topicVector.size(); ++i){
    
        subscriberRequest reqObj;

        reqObj.topic_id = uxr_object_id(topicVector[i].topic_id, UXR_TOPIC_ID);
        reqObj.topic_req = uxr_buffer_create_topic_xml(&session, reliable_out, reqObj.topic_id, participant_id, topicVector[i].topic_xml.c_str(), UXR_REPLACE);
        std::cout<<"topic id: "<<topicVector[i].topic_id<<std::endl;
        std::cout<<"topic name: "<<topicVector[i].topicname<<std::endl;

        reqObj.subscriber_id = uxr_object_id(topicVector[i].topic_id, UXR_SUBSCRIBER_ID);
        reqObj.subscriber_req = uxr_buffer_create_subscriber_xml(&session, reliable_out, reqObj.subscriber_id, participant_id, subscriber_xml, UXR_REPLACE);

        reqObj.datareader_id = uxr_object_id(topicVector[i].topic_id, UXR_DATAREADER_ID);
        reqObj.datareader_req = uxr_buffer_create_datareader_xml(&session, reliable_out, reqObj.datareader_id, reqObj.subscriber_id, topicVector[i].datareader_xml.c_str(), UXR_REPLACE);

        subscriberVector.push_back(reqObj);

        // std::cout<<"start: "<<start<<std::endl;

        requests[start++] = reqObj.topic_req;
        requests[start++] = reqObj.subscriber_req;
        requests[start++] = reqObj.datareader_req;

    }
    uint8_t status[request_size];
    // Send create entities message and wait its status
    if(!uxr_run_session_until_all_status(&session, 1000, requests, status, request_size))
    {   
        uint16_t i = START_IDX;
        printf("Error at create entities: participant: %i \n",status[i++]);
        while( i< sizeof(status)/sizeof(uint8_t) ){
            std::cout<<"topic: "<<status[i++]<<std::endl;
            std::cout<<"subscriber: "<<status[i++]<<std::endl;
            std::cout<<"datareader: "<<status[i++]<<std::endl;
        }
        return;
    }

    // Request topics
    uxrDeliveryControl delivery_control = {0};
    delivery_control.max_samples = UXR_MAX_SAMPLES_UNLIMITED;
    uint16_t read_data_req[topicVector.size()];

    for (size_t i = 0; i < subscriberVector.size(); ++i){
        read_data_req[i] = uxr_buffer_request_data(&session, reliable_out, subscriberVector[i].datareader_id, reliable_in, &delivery_control);
    }

    // Read topics
    bool running = true;
    while(running)
    {
        uint8_t data_status;
        for (size_t i = 0; i < subscriberVector.size(); ++i){
            (void) uxr_run_session_until_all_status(&session, UXR_TIMEOUT_INF, &subscriberVector[i].datareader_req, &data_status, 1);
        }
    }
}

bool Subscriber::initializeSession(const std::string& ip, const std::string& port) {
    if (!uxr_init_udp_transport(&transport, UXR_IPv4, ip.c_str(), port.c_str())) {
        std::cerr<<"Error: transport initialization error"<<std::endl;
        return false;
    }

    uxr_init_session(&session, &transport.comm, 0xCCCCDDDD);
    // uxr_set_topic_callback(&session, onTrackTopic, this);
    uxr_set_topic_callback(&session, onTopic, this);

    if (!uxr_create_session(&session)) {
        std::cerr<<"Error: session creation error"<<std::endl;
        return false;
    }

    return true;
}

void Subscriber::onTopic(uxrSession* session, uxrObjectId topic_id, uint16_t request_id, uxrStreamId stream_id, struct ucdrBuffer* mb, uint16_t length, void* args) {
    (void) session; (void) topic_id; (void) request_id; (void) stream_id; (void) length;
    // printf("Request ID onQtStructTopic %d \n", request_id);
    printf("object_id onTopic ID.ID %d \n", topic_id.id);
    printf("object_id onTopic ID.type %d \n", topic_id.type);

    Subscriber* subscriber = static_cast<Subscriber*>(args);
    if (!subscriber) {
        std::cerr << "Error: Subscriber instance is null." << std::endl;
        return;
    }
    
    if(topic_id.id == OWNSHIP_DATA_RECEIVED)
    {
        // Deserialize the received topic
        CourseSpeedDepth qtStructTopic;
        CourseSpeedDepth_deserialize_topic(mb, &qtStructTopic);

        // Process the received topic
        printf("Received qtStructTopic\n");
        printf("Received QtStruct topic - Course: %f, Speed: %f, Depth: %f\n", qtStructTopic.course, qtStructTopic.speed, qtStructTopic.depth);

        // Emit the received topic
        emit subscriber->qtStructTopicReceived(qtStructTopic);
    }

    if(topic_id.id == TRACK_RECEIVED)
    {
        // Deserialize the received topic
        TrackType trackTopic;
        TrackType_deserialize_topic(mb, &trackTopic);

        // Process the received topic
        printf("Received trackTopic\n");
        printf("Received topic - ShipID: %s, Range: %f, Bearing: %f, Sensor ID: %f, Speed: %f, Timestamp: %.3f\n", trackTopic.shipID, trackTopic.range, trackTopic.bearing, trackTopic.sensor_ID, trackTopic.speed, trackTopic.sensor_timestamp);

        emit subscriber->trackTopicReceived(trackTopic);
    }
}
