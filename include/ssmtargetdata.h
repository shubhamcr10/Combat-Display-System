#ifndef SSMTARGETDATA_H
#define SSMTARGETDATA_H

#include <QObject>

class SSMTargetData: public QObject
{
    Q_OBJECT
public:
    explicit SSMTargetData(QObject *parent = nullptr);
    ~SSMTargetData();
};

#endif // SSMTARGETDATA_H
