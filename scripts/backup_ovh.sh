#/bin/sh

CONFIG="${HOME}/.config/backup_ovh.conf"
if [ ! -f "$CONFIG" ] ; then
    echo "[ERROR] config expected at $CONFIG"
    echo "[ERROR] Expected content:"
    echo "    URI_BACKUP=  # An URI to access to trigger a backup"
    echo "    USERNAME=  # The user to the ftp server"
    echo "    PASSWORD=  # The password to the ftp server"
    echo "    HOST=  # The host to backup"
    echo "    DESTDIR=\"\${HOME}/Téléchargements/\${HOST}\"  # Where to store the backup"
    exit 1
fi

source "${CONFIG}"

wget -qnv -O - ${URI_BACKUP} > /dev/null
lftp -u $USERNAME,$PASSWORD "ftp://$HOST" -e "mirror -e . -P10 $DESTDIR ; quit"
echo $(date -I) > $DESTDIR/backup_date.txt
