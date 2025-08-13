#!/bin/bash
NAME="tsumugi";
DIR="/home/tetraloba/jiho";
DEVICE="plughw:1,0"

# you should call this command at HH:59 (NOT HH:00!)
# $1 (argument 1) is HOUR to echo.
function play_nico() {
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

    sleep 46;
    aplay -D ${DEVICE} ${DIR}/${NAME}/nico.wav;
    aplay -D ${DEVICE} ${DIR}/${NAME}/name.wav;
    aplay -D ${DEVICE} ${DIR}/${NAME}/${SEQ}.wav;
    aplay -D ${DEVICE} ${DIR}/${NAME}/${HOUR}.wav;
    aplay -D ${DEVICE} ${DIR}/${NAME}/shirase.wav;
    sleep 1;
    aplay -D ${DEVICE} ${DIR}/${NAME}/jiho.wav;
    exit;
}

# $1 (argument 1) is HOUR to echo.
function play_short() {
    if test $# -ne 1; then
	echo "invalid arguments";
	exit;
    fi;

    HOUR=$1;
    NUM=$(printf "%03d" $((HOUR + 1)))

    aplay -D ${DEVICE} ${DIR}/mix_short/${HOUR}.wav;
    exit;
}


TYPE="nico"; # default

while getopts t:r OPT; do
    case $OPT in
        t) TYPE=$OPTARG ;; # nico or short
        r) RANDOM=1 ;;
        *) exit 1 ;;
    esac
done


case $TYPE in
    nico) play_nico $(( (`date "+%-H"` + 1) % 24 )) ;;
    short) play_short $(( (`date "+%-H"`) % 24 )) ;;
    *) echo "TYPE ${TYPE} not exist." ;;
esac

exit;

