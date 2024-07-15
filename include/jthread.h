#ifndef JTHREAD_H
#define JTHREAD_H

#include <QThread>

class JThread : public QThread
{
    Q_OBJECT
public:
    JThread(QObject *parent = nullptr);
    void stopThread();
    bool stop=false;
public slots:
    void run();

signals:
    void listen();
};

#endif // JTHREAD_H
