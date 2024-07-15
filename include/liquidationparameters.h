#ifndef LIQUIDATIONPARAMETERS_H
#define LIQUIDATIONPARAMETERS_H

#include <QObject>

class LiquidationParameters : public QObject
{
    Q_OBJECT
public:
    explicit LiquidationParameters(QObject *parent = nullptr);
    ~LiquidationParameters();

signals:

};

#endif // LIQUIDATIONPARAMETERS_H
