#ifndef TRAJECTORYCOMPUTATION_H
#define TRAJECTORYCOMPUTATION_H

#include <QObject>

class TrajectoryComputation : public QObject
{
    Q_OBJECT
public:
    explicit TrajectoryComputation(QObject *parent = nullptr);
    ~TrajectoryComputation();

signals:

};

#endif // TRAJECTORYCOMPUTATION_H
