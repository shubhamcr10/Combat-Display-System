#include "tracks.h"
#include <cmath>
#include<QDateTime>
#include<algorithm>

Tracks::Tracks(QObject *parent) : QObject(parent),
    m_trackId(""),
    m_range("0.0"),
    m_bearing("0.0")
{

}

QString Tracks::getTrackId() const
{
    return m_trackId;
}

QString Tracks::getRange() const
{
    return m_range;
    // return QString::number(m_lat);
}

QString Tracks::getBearing() const
{
    // return QString::number(m_long);
    return m_bearing;
}

void Tracks::setTrackId(QString trackId)
{
    qDebug() << "TrackId:" << trackId;
    if(m_trackId == trackId)
        return;

    m_trackId = trackId;
    emit trackIdChanged(m_trackId);
}
void Tracks::setRange(QString lat)
{
    qDebug() << "Lat:" << lat;
    // qDebug() << "Lat:" << QString::number(lat);
    if(m_range == lat)
        return;

    m_range = lat;
    emit rangeChanged(m_range);
}

void Tracks::setLat(float lat)
{
    m_lat = lat;
}

void Tracks::setLong(float lng)
{
    m_lng = lng;
}

float Tracks::getLat()
{
    return m_lat;
}

float Tracks::getLong()
{
    return m_lng;
}

void Tracks::setSensorId(float sensorId)
{
    QString sensorName;
    int sensorIdInt = static_cast<int>(sensorId); // Cast sensorId to int
    switch(sensorIdInt) {
        case 1:
            sensorName = RARAD1;
            break;
        case 2:
            sensorName = SONAR1;
            break;
        case 3:
            sensorName = SONAR2;
            break;
        default:
            // Handle invalid sensorId
            qDebug() << "Invalid sensorId";
            return;
    }
    m_sensorId = sensorId;
    m_sensorName = sensorName;
}

void Tracks::setSpeed(float speed)
{
    m_speed = speed;
}

void Tracks::setTimestamp(double timestamp)
{
    m_timestamp = timestamp;
}

QString Tracks::getSensorId()
{
    return m_sensorName;
}

float Tracks::getSpeed()
{
    return m_speed;
}

double Tracks::getTimestamp()
{
    return m_timestamp;
}

void Tracks::setBearing(QString lng)
{
    qDebug() << "Long:" << lng;
    // qDebug() << "Long:" << QString::number(lng);
    if(m_bearing == lng)
        return;

    m_bearing = lng;
    emit bearingChanged(m_bearing);
}

std::pair<float, float> Tracks::calculateLatLongFromRangeBearing(float range, float bearing) {
    // Earth's radius in nautical miles
    // const float RADIUS_EARTH = 3443.92;

    // float Reflat = 0;
    // float Reflng = 0;

    // printf("Reference Latitude: %f, Reference Longitude: %f \n", Reflat , Reflng);
    // printf("Detected Track's Range: %f, Bearing in Degree: %f \n", range, true_bearing);

    // // Convert true bearing to radians
    // float brng = true_bearing * M_PI / 180.0;

    // // Convert latitude and longitude to radians
    // float lat1 = Reflat * M_PI / 180.0;
    // float lon1 = Reflng * M_PI / 180.0;

    // // Calculate new latitude
    // float lat2 = asin(sin(lat1) * cos(range / RADIUS_EARTH) +
    //                   cos(lat1) * sin(range / RADIUS_EARTH) * cos(brng));

    // // Calculate new longitude
    // float lon2 = lon1 + atan2(sin(brng) * sin(range / RADIUS_EARTH) * cos(lat1),
    //                            cos(range / RADIUS_EARTH) - sin(lat1) * sin(lat2));

    // // Convert radians back to degrees
    // float lat = lat2 * 180.0 / M_PI;
    // float lng = lon2 * 180.0 / M_PI;

    // // Adjust longitude to be within the range [-180, 180]
    // lng = fmod((lng + 180.0), 360.0);
    // if (lng < 0)
    //     lng += 360.0;
    // lng -= 180.0;
    // float angleRadians = ((true_bearing)* M_PI) / 180;
    
    float angleRadians = ((bearing)* M_PI) / ANGLE180;

    float lat = range * sin(angleRadians);
    float lng = range * cos(angleRadians);

    qDebug() << "Calculated Latitude:" << lat << "Longitude:" << lng;

    return std::make_pair(lat, lng);
}


QVariantList Tracks::getTracksList() const {
    QVariantList tracksList;
    for (const auto &track : m_tracks) {
        QVariantMap trackMap;
        QString trackIDD = track->getTrackId();
        QString range = track->getRange();
        QString bearing = track->getBearing();

        float latitude = track->getLat();
        float longitude = track->getLong();

        // qDebug() << "Track ID:" << trackIDD << ", Latitude:" << latitude << ", Longitude:" << longitude;
        
        trackMap["trackId"] = trackIDD;
        trackMap["latitude"] = latitude;
        trackMap["longitude"] = longitude;
        trackMap["range"] = range;
        trackMap["bearing"] = bearing;
        trackMap["sensorID"] = track->getSensorId();
        trackMap["speed"] = track->getSpeed();
        trackMap["timestamp"] = track->getTimestamp();
        tracksList.append(trackMap);

        qDebug() << " trackId: "<<trackIDD;
    }
    return tracksList;
}

void Tracks::addOrUpdateTrack(const TrackType &topic) {
    QString trackId = QString::fromUtf8(topic.shipID);

    // Calculate latitude and longitude from range and bearing
    std::pair<float, float> latLng = calculateLatLongFromRangeBearing(topic.range, topic.bearing);
    float latitude = latLng.first;
    float longitude = latLng.second;

    int bearing = static_cast<int>(topic.bearing) % ANGLE360;

    qDebug() << "Received Track ID:" << trackId << "Latitude:" << latitude << "Longitude:" << longitude;

    auto it = std::find_if(m_tracks.begin(), m_tracks.end(), [trackId](const Tracks *track) {
        return track->getTrackId() == trackId;
    });
    QVariantMap trackMap;
    if (it != m_tracks.end()) {
        // Update existing track
        Tracks *track = *it;
        qDebug() << "Updating existing track with ID:" << trackId;
//        track->setRange(QString::number(latitude));
//        track->setBearing(QString::number(longitude));
        track->setLat(latitude);
        track->setLong(longitude);
        track->setRange(QString::number(topic.range));
        track->setBearing(QString::number(bearing));
        track->setSensorId(topic.sensor_ID);
        track->setSpeed(topic.speed);
        track->setTimestamp(topic.sensor_timestamp);
//      ****************************************************
        QString trackIDD = track->getTrackId();
        QString range = track->getRange();
        QString bearing = track->getBearing();

        float latitude = track->getLat();
        float longitude = track->getLong();

        // qDebug() << "Track ID:" << trackIDD << ", Latitude:" << latitude << ", Longitude:" << longitude;

        trackMap["trackId"] = trackIDD;
        trackMap["latitude"] = latitude;
        trackMap["longitude"] = longitude;
        trackMap["range"] = range;
        trackMap["bearing"] = bearing;
        trackMap["sensorID"] = track->getSensorId();
        trackMap["speed"] = track->getSpeed();
        trackMap["timestamp"] = track->getTimestamp();

//      ****************************************************
    } else {
        // Create new track
        Tracks *newTrack = new Tracks();
        qDebug() << "Creating new track with ID:" << trackId;
        newTrack->setTrackId(trackId);
        newTrack->setLat(latitude);
        newTrack->setLong(longitude);
        newTrack->setRange(QString::number(topic.range));
        newTrack->setBearing(QString::number(bearing));
        newTrack->setSensorId(topic.sensor_ID);
        newTrack->setSpeed(topic.speed);
        newTrack->setTimestamp(topic.sensor_timestamp);
        m_tracks.push_back(newTrack);

        //      ****************************************************
                QString trackIDD = newTrack->getTrackId();
                QString range = newTrack->getRange();
                QString bearing = newTrack->getBearing();

                float latitude = newTrack->getLat();
                float longitude = newTrack->getLong();

                // qDebug() << "Track ID:" << trackIDD << ", Latitude:" << latitude << ", Longitude:" << longitude;

                trackMap["trackId"] = trackIDD;
                trackMap["latitude"] = latitude;
                trackMap["longitude"] = longitude;
                trackMap["range"] = range;
                trackMap["bearing"] = bearing;
                trackMap["sensorID"] = newTrack->getSensorId();
                trackMap["speed"] = newTrack->getSpeed();
                trackMap["timestamp"] = newTrack->getTimestamp();

        //      ****************************************************
    }
//    emit tracksListUpdated();
    emit tracksListNewUpdated(trackMap);
}

void Tracks::checkTimestampDifference() {
    // Current timestamp
    qint64 currentTimestamp = QDateTime::currentMSecsSinceEpoch();
    // Iterate over tracks and remove outdated ones
    m_tracks.erase(std::remove_if(m_tracks.begin(), m_tracks.end(), [&](Tracks* track) {
        qint64 trackTimestamp = track->getTimestamp();
        qint64 timestampDifference = currentTimestamp - trackTimestamp;
        // Check if timestamp difference exceeds 30 seconds
        if (timestampDifference > TRACK_MAX_TIME) {
            // Emit signal to notify track removal
            emit trackRemoved(track->getTrackId());
//            emit tracksListUpdated();
            return true; // Remove track
        }
        return false; // Keep track
    }), m_tracks.end());
//    emit tracksListUpdated();
}

