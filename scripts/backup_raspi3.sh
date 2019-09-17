#!/bin/zsh

LOGFILE=/home/olivier/.backup.log
BACKUPHOST="olivier@raspi3"
BACKUPDIR="/mnt/auto/MyBook/backups"

BACKUPSRC=( \
    "/home/olivier/Images" \
    "/home/olivier/Documents" \
    )
echo "-------------$(date +'%Y/%m/%d %H:%M:%S')------------- >> $LOGFILE"

for d in $BACKUPSRC; do
#  echo "rsync -av --delete --log-file=$LOGFILE \"$d\" \"$BACKUPDIR\" &> /dev/null"
  rsync -av --delete --log-file=$LOGFILE "$d" $BACKUPHOST:"$BACKUPDIR" &> /dev/null
done

cat $LOGFILE | grep -ve "building" -ve "sent" -ve "total size" >> $LOGFILE.tmp

mv $LOGFILE.tmp $LOGFILE
