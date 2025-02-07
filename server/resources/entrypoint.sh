#!/usr/bin/env bash
set -Eeuo pipefail

# root scripts
echo "${ROOT_PASSWORD}" | su root -c " \
    hostname ${HOSTNAME} && \
    source ${RES_PATH}/scripts/define.sh && \
    source ${RES_PATH}/builds/create_user.sh \
"

# user scripts
echo "${PASSWORD}" | su ${USERNAME} -c " \
    source ${RES_PATH}/scripts/define.sh && \
    source ${RES_PATH}/scripts/info.sh \
"

tail -f /dev/null

