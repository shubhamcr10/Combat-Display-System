#ifndef WAYPOINTS_H
#define WAYPOINTS_H

#include <QObject>

class WayPoints : public QObject
{
    Q_OBJECT
public:
    explicit WayPoints(QObject *parent = nullptr);
    ~WayPoints();

signals:

};

#endif // WAYPOINTS_H
