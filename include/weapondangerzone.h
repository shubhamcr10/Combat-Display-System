#ifndef WEAPONDANGERZONE_H
#define WEAPONDANGERZONE_H

#include <QObject>

class WeaponDangerZone : public QObject
{
    Q_OBJECT
public:
    explicit WeaponDangerZone(QObject *parent = nullptr);
    ~WeaponDangerZone();

signals:

};

#endif // WEAPONDANGERZONE_H
