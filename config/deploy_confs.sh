#!/bin/sh

PROG=$(basename $0)
help() {
    echo "Usage: $PROG [--check|--deploy]"
}

LOG() {
    echo "[INFO] $1"
}

file_check() {
    if cmp --silent -- "$2" "$1"; then
        LOG "$2 is up-to-date"
    else
        LOG "$1 and $2 differ"
    fi
}

file_install() {
    if cmp --silent -- "$2" "$1"; then
        LOG "$2 is up-to-date"
    else
        sudo cp "$1" "$2"
        LOG "installed $1 in $2"
    fi
}

if [ "$#" -ne 1 ] ; then
    help
    exit 1
fi

if [ "$1" = "--check" ] ; then
    alias _command=file_check
elif [ "$1" = "--deploy" ] ; then
    alias _command=file_install
elif "$1" = "--help" ; then
    help
    exit 0
else
    help
    exit 1
fi

BASEDIR=$(dirname $0)
_command ${BASEDIR}/vimrc /etc/vimrc
_command ${BASEDIR}/zshrc /etc/zsh/zshrc
