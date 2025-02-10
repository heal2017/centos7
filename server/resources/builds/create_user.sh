#!/usr/bin/env bash
set -Eeuo pipefail

{ echo "root:${ROOT_PASSWORD}" | chpasswd; rc=$?; } || :
if [ "$rc" == "0" ]; then
    success "chpasswd:  change root password (${ROOT_PASSWORD}) ok"
else
    failure "chpasswd:  change root password (${ROOT_PASSWORD}) failed"
fi

# create group user
if [ "${USERNAME}" == "root" ]; then
    failure "Environment: USERNAME can not be ${USERNAME}!" && exit 1
else
    # create group
    if getent group ${USERNAME} > /dev/null; then
        warning "groupadd:  group ${USERNAME} exist! skip..."
    elif getent group ${GID} > /dev/null; then
        warning "groupadd:  gid ${GID} exist! skip..."
    else
        { groupadd ${USERNAME} -g ${GID}; rc=$?; } || :
        if [ "$rc" == "0" ]; then
            success "groupadd:   create group ${USERNAME}(${GID}) ok"
        else
            failure "groupadd:   create group ${USERNAME}(${GID}) failed"
        fi
    fi

    # create user
    if getent passwd ${USERNAME} > /dev/null; then
        warning "useradd:   username ${USERNAME} exist! skip..."
    elif getent passwd ${UID} > /dev/null; then
        warning "useradd:   uid ${UID} exist! skip..."
    else
        { \
            useradd ${USERNAME} -u ${UID} -g ${GID} -m -s ${USERSHELL}; \
            echo "${USERNAME}:${PASSWORD}" | chpasswd; \
            rc=$?; \
        } || :
        if [ "$rc" == "0" ]; then
            success "useradd:   create user ${USERNAME}(${UID}) ok"
        else
            failure "useradd:   create user ${USERNAME}(${UID}) failed"
        fi
    fi
fi

