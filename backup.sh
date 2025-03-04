#!/bin/bash

function now() {
    date -u +"%Y-%m-%d_%H-%M-%S"z
}

base_dir=$(dirname "$0")
base_name=$(basename -- "$0")
log_dir=$base_dir/$base_name'.logs'
logfile=$log_dir/$base_name'_'`now`.log

if [ ! -d $log_dir ]; then
    mkdir $log_dirv
fi

argumentos="-vhaz --delete"

if [ "$#" -gt 0 ] && [ -f $1 ]; then
    argumentos="${argumentos} --exclude-from="${1}
fi

rsync $argumentos /media/data1 /media/backups &>> $logfile