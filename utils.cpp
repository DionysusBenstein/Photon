/*******************************************************************/

/* Original File Name: utils.qml                                   */

/* Date: 18-07-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Реализация Класса выполнения специализированных
                типовых задач.                                     */

/*******************************************************************/

#include "utils.h"

Utils::Utils(QObject *parent) : QObject(parent) {}

QString Utils::msToTime(int duration)
{
    QString seconds = QString::number((duration / 1000) % 60);
    QString minutes = QString::number((duration / (1000 * 60)) % 60);
    QString hours   = QString::number((duration / (1000 * 60 * 60)) % 60);

    seconds = seconds.toInt() < 10 ? "0" + seconds : seconds;

    if (hours != "0")
    {
        minutes = minutes.toInt() < 10 ? "0" + minutes : minutes;
        return hours + ":" + minutes + ":" + seconds;
    }
    else
    {
        return minutes + ":" + seconds;
    }
}

int Utils::timeToMs(int hours, int minutes, int seconds)
{
    int ms;

    if (hours != 0)
        ms = hours * 3600000;

    if (minutes != 0)
        ms += minutes * 60000;

    if (seconds != 0)
        ms += seconds * 1000;

    return ms;
}
