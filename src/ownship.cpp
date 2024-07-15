#include "ownship.h"
#include <QDebug>

OwnShip::OwnShip(QObject *parent) : QObject(parent),
    m_course("0.0"),
    m_speed("0.0"),
    m_depth("0.0"),
    mTimer(new QTimer(this)),
    mTimeoutVal(0),
    m_courseInFloat(30.1),
    m_speedInFloat(32.2),
    m_depthInFloat(35.5)
{

//    subscriber = new Subscriber(ip, port, max_topics,this);

//    connect(mTimer, &QTimer::timeout, [=]() {
//            ++mTimeoutVal;
//        m_courseInFloat += 1.0;
//        if(m_courseInFloat >= MAX_COURSE_VALUE)
//            m_courseInFloat = MIN_COURSE_VALUE;
//        m_speedInFloat += 1.0;
//        if(m_speedInFloat >= MAX_SPEED_VALUE)
//            m_speedInFloat = MIN_SPEED_VALUE;
//        m_depthInFloat += 1.0;
//        if(m_depthInFloat >= MAX_DEPTH_VALUE)
//            m_depthInFloat = MIN_DEPTH_VALUE;
//        setCourse(QString::number(m_courseInFloat));
//        setSpeed(QString::number(m_speedInFloat));
//        setDepth(QString::number(m_depthInFloat));
//        });
//        mTimer->start(1000);

        // Connect the signal from Subscriber to slots in OwnShip
//        connect(subscriber, &Subscriber::topicReceived, this, &OwnShip::onTopicReceived);
//        connect(subscriber, &Subscriber::topicReceived,[=](const CourseSpeedDepth &topic) {
//        setCourse(QString::number(topic.course));
//        setSpeed(QString::number(topic.speed));
//        setDepth(QString::number(topic.depth));
//        });
//        subscriber->start();
}

QString OwnShip::course() const
{
    return m_course;
}

QString OwnShip::speed() const
{
    return m_speed;
}

QString OwnShip::depth() const
{
    return m_depth;
}

void OwnShip::setCourse(QString course)
{
    qDebug() << "setCourse:" << course;
    if (m_course == course)
        return;

    m_course = course;
    emit courseChanged(m_course);
}

void OwnShip::setSpeed(QString speed)
{
    qDebug() << "setSpeed:" << speed;
    if (m_speed == speed)
        return;

    m_speed = speed;
    emit speedChanged(m_speed);
}

void OwnShip::setDepth(QString depth)
{
    qDebug() << "setDepth:" << depth;
    if (m_depth == depth)
        return;

    m_depth = depth;
    emit depthChanged(m_depth);
}

void OwnShip::onTopicReceived(const CourseSpeedDepth &topic){
            setCourse(QString::number(topic.course));
            setSpeed(QString::number(topic.speed));
            setDepth(QString::number(topic.depth));
}
