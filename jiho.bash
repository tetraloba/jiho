#!/bin/bash
# $1 (argument 1) is HOUR to echo.
NAME="tsumugi";
DIR="/home/tetraloba/jiho/${NAME}";
DEVICE="plughw:1,0"

function play () {
    if test $# -ne 1; then
	echo "invalid arguments";
	exit;
    fi;

    HOUR=$1;
    if test $((${HOUR} / 12)) -eq 0; then
        SEQ="zen";
    else
        SEQ="go";
    fi;
    HOUR=$(($1 % 12));

    aplay -D ${DEVICE} ${DIR}/nico.wav;
    aplay -D ${DEVICE} ${DIR}/name.wav;
    aplay -D ${DEVICE} ${DIR}/${SEQ}.wav;
    aplay -D ${DEVICE} ${DIR}/${HOUR}.wav;
    aplay -D ${DEVICE} ${DIR}/shirase.wav;
    sleep 1;
    aplay -D ${DEVICE} ${DIR}/jiho.wav;
    exit;
}

# call this command at HH:59 (NOT HH:00!)
sleep 46;
play $(( (`date "+%-H"` + 1) % 24 ));
exit;

