#include "utils.h"

utils::utils(QObject *parent) : QObject(parent) {}

QString utils::msToTime(int duration)
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
