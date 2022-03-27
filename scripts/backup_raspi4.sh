#!/bin/zsh

set -e

LOGFILE=/home/olivier/.backup-rpi4.log
BACKUP_HOST="olivier@raspi4"
BACKUP_ROOTPATH="/mnt/auto/MyBook/backups/${HOST}"
BACKUP_DIR_PREFIX="backup"
BACKUP_FULLPATH_PREFIX="${BACKUP_ROOTPATH}/${BACKUP_DIR_PREFIX}"
CURRENT_BACKUP_DIR="${BACKUP_DIR_PREFIX}.0"
CURRENT_BACKUP_FULLPATH="${BACKUP_ROOTPATH}/${CURRENT_BACKUP_DIR}"
CURRENT_BACKUP_FULLPATH_TMP="${CURRENT_BACKUP_FULLPATH}.tmp"
MAX_ROTATION=12

# Define paths to backup
BACKUP_SRC=( \
    "/home/olivier/Images" \
    "/home/olivier/Documents" \
    )

# New line in the logfile
echo "-------------$(date +'%Y/%m/%d %H:%M:%S')-------------" >> $LOGFILE

echo "## PREPARE DESTINATION ##" >> $LOGFILE
ssh ${BACKUP_HOST} "mkdir -p  \"${CURRENT_BACKUP_FULLPATH}\"" 

for d in $BACKUP_SRC; do
#  echo "rsync -av --delete --log-file=$LOGFILE \"$d\" \"$BACKUPDIR\" &> /dev/null"
#  rsync -az --delete --link-dest="${PREVIOUS_BACKUP_FULLPATH}" --log-file=$LOGFILE "$d" ${BACKUP_HOST}:"${CURRENT_BACKUP_FULLPATH}" &> /dev/null
#  Comme on est sur du ntfs, on ne peut pas conserver les droits (-p), les groupes (-p) ..., sinon on utiliserait -a
    echo "## SYNC $d ##" >> $LOGFILE
    rsync -vrtlz --delete --link-dest="${CURRENT_BACKUP_FULLPATH}" --log-file=$LOGFILE "$d" ${BACKUP_HOST}:"${CURRENT_BACKUP_FULLPATH_TMP}" &> /dev/null
done

echo "## START ROTATION ##" >> $LOGFILE
#echo "ssh $BACKUPHOST \"rm -rf ${BACKUPPATH_PATTERN}.${MAX_ROTATION} ; \

ssh ${BACKUP_HOST} "[[ -d ${BACKUP_FULLPATH_PREFIX}.${MAX_ROTATION} ]] && rm -rf ${BACKUP_FULLPATH_PREFIX}.${MAX_ROTATION} ; \
    for k in {${MAX_ROTATION}..1} ; \
        do [[ -d  \"${BACKUP_FULLPATH_PREFIX}.\$((k-1))\" ]] && mv \"${BACKUP_FULLPATH_PREFIX}.\$((k-1))\" \"${BACKUP_FULLPATH_PREFIX}.\${k}\" ; \
    done && \
    mv \"${CURRENT_BACKUP_FULLPATH_TMP}\" \"${CURRENT_BACKUP_FULLPATH}\""

SSH_RETURN=$?

if [ "${SSH_RETURN}" -ne 0 ] ; then
    echo "## [ERROR] ROTATION FAILED ##" >> $LOGFILE
    exit 1
else
    echo "## ROTATION DONE ##" >> $LOGFILE
fi

cat $LOGFILE | grep -ve "building" -ve "sent" -ve "total size" -ve ".d...p.g..." >> $LOGFILE.tmp

mv $LOGFILE.tmp $LOGFILE

