#!/bin/env bash
set -Eeuo pipefail

# Print System Infos
HOSTNAME=$(hostname -s)
KERNEL=$(uname -r)
ARCH=$(uname -m)
CPU=$(lscpu | grep '^Model name:' | awk -F ':' '{print $2}' | sed 's/^[ ]*//;s/[ ]*$//')
CORES=$(grep -c '^processor' /proc/cpuinfo)
RAM_AVAIL=$(free -b | grep -m 1 Mem: | awk '{print $7}')
RAM_TOTAL=$(free -b | grep -m 1 Mem: | awk '{print $2}')
AVAIL_GB=$(echo "${RAM_AVAIL}" | awk '{printf("%.1f\n"), $1/1073741824}')
TOTAL_GB=$(echo "${RAM_TOTAL}" | awk '{printf("%.1f\n"), $1/1073741824}')
USED_GB=$(echo "${RAM_TOTAL} ${RAM_AVAIL}" | awk '{printf("%.1f\n"), ($1-$2)/1073741824}')
USED_PER=$(echo "$RAM_AVAIL $RAM_TOTAL" | awk '{printf("%.1f\n"), ($2-$1)/$2*100}')

information    "HOSTNAME:  ${HOSTNAME}"
information    "KERNEL:    ${KERNEL}"
information    "ARCH:      ${ARCH}"
information    "CPU:       ${CPU}"
information    "CORES:     ${CORES}"
information    "RAM:       ${USED_GB}GB/${TOTAL_GB}GB ${USED_PER}%"

