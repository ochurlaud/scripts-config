#! /bin/sh

function usage() {
    echo "Usage: decrypt_dir.sh INPUT OUTPUT"
    exit $1
}

if [[ "$#" -eq "1" ]] && [[ "$1" == "--help" ]] ; then
    usage 0
fi

if [[ "$#" -eq 2 ]] ; then
    INPUT=$1
    OUTPUT=$2
    mkdir -p $2
    openssl enc -d -aes-256-cbc -pbkdf2 -in $INPUT | tar xz -C $OUTPUT
    exit $?
fi

usage 1


