#/bin/sh

if [ ! -f ~/.config/getftp.conf ] ; then
    echo "[ERROR] config expected at ~/.config/getftp.conf"
    exit 1
fi

source ~/.config/getftp.conf

wget -qnv -O - ${URI_BACKUP} > /dev/null
lftp -u $USERNAME,$PASSWORD "ftp://$HOST" -e "mirror -e . -P10 $DESTDIR ; quit"
echo $(date -I) > $DESTDIR/backup_date.txt
