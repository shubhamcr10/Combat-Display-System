#ifndef OWNSHIP_H
#define OWNSHIP_H

#include <QObject>
#include <QTimer>
#include "TopicDefinitions.h"

const float MIN_COURSE_VALUE = 30.1;
const float MAX_COURSE_VALUE = 40.0;
const float MIN_SPEED_VALUE = 32.2;
const float MAX_SPEED_VALUE = 42.0;
const float MIN_DEPTH_VALUE = 35.5;
const float MAX_DEPTH_VALUE = 45.0;

class OwnShip : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString course READ course WRITE setCourse NOTIFY courseChanged)
    Q_PROPERTY(QString speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(QString depth READ depth WRITE setDepth NOTIFY depthChanged)

public:
    explicit OwnShip(QObject *parent = nullptr);

QString course() const;

QString speed() const;

QString depth() const;

public slots:
void setCourse(QString course);

void setSpeed(QString speed);

void setDepth(QString depth);

void onTopicReceived(const CourseSpeedDepth &topic);

signals:

void courseChanged(QString course);

void speedChanged(QString speed);

void depthChanged(QString depth);

private:
QString m_course;
QString m_speed;
QString m_depth;
float m_courseInFloat;
float m_speedInFloat;
float m_depthInFloat;
QTimer *mTimer;
int mTimeoutVal;

//Subscriber *subscriber;

};

#endif // OWNSHIP_H
