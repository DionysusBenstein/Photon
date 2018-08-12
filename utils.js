/*******************************************************************/

/* Original File Name: utils.js                                    */

/* Date: 05-08-2018                                                */

/* Developer: Dionysus Benstein                                    */

/* Copyright © 2018 Dionysus Benstein. All rights reserved.        */

/* Description: Основные JS функции.                               */

/*******************************************************************/

function msToTime(duration) {
    var seconds = parseInt((duration / 1000) % 60);
    var minutes = parseInt((duration / (1000 * 60)) % 60);
    var hours   = parseInt((duration / (1000 * 60 * 60)) % 60);

    seconds = (seconds < 10) ? "0" + seconds : seconds;

    if (hours !==  0) {
        minutes = (minutes < 10) ? "0" + minutes : minutes;
        return hours + ":" + minutes + ":" + seconds;
    } else {
        return minutes + ":" + seconds;
    }
}

function timeToMs(hours, minutes, seconds) {
    var ms;

    if (hours !== undefined) {
        ms = hours * 3600000;
    }

    if (minutes !== undefined) {
        ms += minutes * 60000;
    }

    if (seconds !== undefined) {
        ms += seconds * 1000;
    }

    return ms;
}
