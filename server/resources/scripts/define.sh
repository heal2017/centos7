#!/bin/env bash
set -Eeuo pipefail

# Define log Methods
NC='\033[0m'
DC='\033[0;39m'

Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'

BlackBold="${Black//0;/1;}"
RedBold="${Red//0;/1;}"
GreenBold="${Green//0;/1;}"
YellowBold="${Yellow//0;/1;}"
BlueBold="${Blue//0;/1;}"
PurpleBold="${Purple//0;/1;}"
CyanBold="${Cyan//0;/1;}"
WhiteBold="${White//0;/1;}"
DCBold="${DC//0;/1;}"

getTime() {
    echo $(date '+%H:%M:%S')
    return 0
}

information() {
    local ctime=$(getTime)
    echo -en "[${WhiteBold} INFO ${DC}] ${CyanBold}${ctime} ${DCBold}$1 ${DC}\n"
    return 0
}

warning() {
    local ctime=$(getTime)
    echo -en "[${YellowBold} WARN ${DC}] ${CyanBold}${ctime} ${YellowBold}$1 ${DC}\n"
    return 0
}

success() {
    local ctime=$(getTime)
    echo -en "[${GreenBold}  OK  ${DC}] ${CyanBold}${ctime} ${GreenBold}$1 ${DC}\n"
    return 0
}

failure() {
    local ctime=$(getTime)
    echo -en "[${RedBold}FAILED${DC}] ${CyanBold}${ctime} ${RedBold}$1 ${DC}\n" >&2
    return 0
}

