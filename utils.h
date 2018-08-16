#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QString>
#include <QDebug>

class utils : public QObject
{
    Q_OBJECT
public:
    explicit utils(QObject *parent = nullptr);
    Q_INVOKABLE QString msToTime(int duration);
    Q_INVOKABLE int timeToMs(int hours, int minutes, int seconds);

};

#endif //UTILS_H