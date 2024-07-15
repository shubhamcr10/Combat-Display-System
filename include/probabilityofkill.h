#ifndef PROBABILITYOFKILL_H
#define PROBABILITYOFKILL_H

#include <QObject>

class ProbabilityOfKill : public QObject
{
    Q_OBJECT
public:
    explicit ProbabilityOfKill(QObject *parent = nullptr);
    ~ProbabilityOfKill();

signals:

};

#endif // PROBABILITYOFKILL_H
