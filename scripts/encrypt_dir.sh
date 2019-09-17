#! /bin/sh

function usage() {
    echo "Usage: encrypt_dir.sh INPUT OUTPUT"
    exit $1
}

if [[ "$#" -eq "1" ]] && [[ "$1" == "--help" ]] ; then
    usage 0
fi

if [[ "$#" -eq 2 ]] ; then
    INPUT=$1
    OUTPUT=$2

    cd $INPUT
    tar -czf - * | openssl enc -e -aes-256-cbc -pbkdf2 -out $OUTPUT
    cd -
    exit $?
fi

usage 1

