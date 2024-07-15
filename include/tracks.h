#ifndef TRACKS_H
#define TRACKS_H

#include <QObject>
#include <QtDebug>
#include <vector>
#include "TopicDefinitions.h"

class Tracks : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString trackId READ getTrackId WRITE setTrackId NOTIFY trackIdChanged)
    Q_PROPERTY(QString longitude READ getBearing WRITE setBearing NOTIFY bearingChanged)
    Q_PROPERTY(QString latitude READ getRange WRITE setRange NOTIFY rangeChanged)
public:
    explicit Tracks(QObject *parent = nullptr);
    QString getTrackId() const;
    QString getRange() const;
    QString getBearing() const;
    Q_INVOKABLE QVariantList getTracksList() const;

public slots:
    void setTrackId(QString trackId);
    void setRange(QString lat);
    void setBearing(QString lng);

    void setLat(float lat);
    void setLong(float lng);

    void setSensorId(float sensorId);
    void setSpeed(float speed);

    void setTimestamp(double timestamp);

    float getLat();
    float getLong();
    double getTimestamp();

    QString getSensorId();
    float getSpeed();

    void checkTimestampDifference();

    // void onTopicReceived(const TrackLatLong &topic);
    void addOrUpdateTrack(const TrackType &topic);
    std::pair<float, float> calculateLatLongFromRangeBearing(float range, float bearing);
    // void handleRangeBearingData(const TrackLatLong &topic);
    
signals:
    void trackIdChanged(QString trackId);
    void rangeChanged(QString lat);
    void bearingChanged(QString lng);
    void tracksListUpdated();
    void tracksListNewUpdated(QVariantMap trackMap);
    void trackRemoved(QString trackId);
    
private:
    QString m_sensorId;
    QString m_sensorName;
    QString m_trackId;
    QString m_range;
    QString m_bearing;
    float m_lat;
    float m_lng;
    float m_speed;
    double m_timestamp;
    std::vector<Tracks*> m_tracks;

};

#endif // TRACKS_H
