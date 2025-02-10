#!/usr/bin/env bash
set -Eeuo pipefail

# locale
localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8

if [ -e /etc/localtime ]; then
    rm -f /etc/localtime
fi
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# vim
tee -a /etc/vimrc <<- 'EOF'
set ts=4
set so=5
set cul
set nu
set expandtab
EOF

