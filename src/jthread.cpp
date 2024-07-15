#include "jthread.h"

JThread::JThread(QObject *parent):
    QThread(parent)
{

}

void JThread::run()
{
    while(true)
    {
        if(this->stop){
            this->stop = false;
            break;
        }
        emit listen();
//        msleep(100);
    }
}

void JThread::stopThread()
{
    this->stop = true;
    this->quit();
    this->wait();
}
