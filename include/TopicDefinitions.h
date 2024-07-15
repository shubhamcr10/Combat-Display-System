#ifndef TOPICDEFINITIONS_H
#define TOPICDEFINITIONS_H

#include <string>
#include <stdint.h>
#include <stdbool.h>
#include <cstring>

#define ANGLE360 360
#define ANGLE180 180

#define RARAD1 "R001"
#define SONAR1 "S001"
#define SONAR2 "S002"

#define TRACK_MAX_TIME 30000


class CourseSpeedDepth {
public:
    float course;
    float speed;
    float depth;
};

class TrackType {
public:
    char shipID[50];
    float range;
    float bearing;
    float sensor_ID;
    float speed;
    double sensor_timestamp;

    // TrackLatLong(){
    // }
    
    // TrackLatLong(const char* shipId, float rangeValue, float bearingValue) {
    //     strcpy(shipID, shipId);
    //     range = rangeValue;
    //     true_bearing = bearingValue;
    // }
}; 

#endif // TOPICDEFINITIONS_H
