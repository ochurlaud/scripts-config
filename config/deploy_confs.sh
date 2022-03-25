#!/bin/sh

LOG() {
    echo "[INFO] $1"
}

file_install() {
    sudo cp "$1" "$2"
    LOG "installed $1 in $2"
}

BASEDIR=$(dirname $0)
file_install ${BASEDIR}/vimrc /etc/vimrc
file_install ${BASEDIR}/zshrc /etc/zshrc
