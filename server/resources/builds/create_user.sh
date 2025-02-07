#!/usr/bin/env bash
set -Eeuo pipefail

echo "root:${ROOT_PASSWORD}" | chpasswd

# create group user
if [ "${USERNAME}" == "root" ]; then
    failure "Environment:   USERNAME can not be ${USERNAME}!" && exit 2
else
    # create group
    if getent group ${USERNAME} > /dev/null; then
        information "Group:     ${USERNAME} exist!"
    elif getent group ${GID} > /dev/null; then
        information "GID:       ${GID} exist!"
    else
        groupadd ${USERNAME} -g ${UID}
    fi

    # create user
    if getent passwd ${USERNAME} > /dev/null; then
        information "USERNAME:  ${USERNAME} exist!"
    elif getent passwd ${UID} > /dev/null; then
        information "UID:       ${UID} exist!"
    else
        useradd ${USERNAME} -u ${UID} -g ${GID} -m -s ${USERSHELL}
        echo "${USERNAME}:${PASSWORD}" | chpasswd
    fi
fi

