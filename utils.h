/*******************************************************************/

/* Original File Name: utils.qml                                   */

/* Date: 18-07-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Класс выполнения специализированных типовых задач. */

/*******************************************************************/

#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QString>
#include <QDebug>

class Utils : public QObject
{
    Q_OBJECT
public:
    explicit Utils(QObject *parent = nullptr);
    Q_INVOKABLE QString msToTime(int duration);
    Q_INVOKABLE int timeToMs(int hours = 0, int minutes = 0, int seconds = 0);

};

#endif //UTILS_H
