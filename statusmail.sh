#!/bin/bash

###############################################################
# (c) 2020 tuxifreund - https://ubuntuusers.de/user/tuxifreund
# und folgenden Code anpassen in die /etc/crontab eintragen:
# @hourly   root  cd /PFAD/ZUM/SKRIPT && bash statusmail.sh
###############################################################

#Grundkonfiguration - bitte anpassen!
MAIL="E-MAIL-ADRESSE" #E-Mail-Adresse des Empfängers

TEMP=$(mktemp)
trap 'rm -f "$TEMP"' 0

#Mailtext

date > $TEMP
hostname >> $TEMP
uname -a >> $TEMP
cat <<MAILTEXT >> "$TEMP"

Sensoren

$(sensors)

-----

Festplattenspeicher

$(df -h)

-----

Uptime

$(uptime)

-----

Status Webserver

$(systemctl status apache2)

Status Postfix

$(systemctl status postfix)

IP-Adresse

$(ip addr)

-----

Netzwerkerreichbarkeit

$(ping -c 2 startpage.com)
MAILTEXT

#Mail versenden
mail -s "Serverstatus" $MAIL < $TEMP

#Temporaere Datei löschen
rm $TEMP
