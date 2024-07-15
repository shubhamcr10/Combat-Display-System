#ifndef COMBAT_H
#define COMBAT_H

#include <QObject>

class Combat : public QObject
{
    Q_OBJECT
public:
    explicit Combat(QObject *parent = nullptr);
    ~Combat();

signals:

};

#endif // COMBAT_H
