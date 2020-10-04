#!/bin/bash

if [ $(id -u) -ne 0 ]; then
 echo "Skript muss als Root gestartet werden"
 exit 1
fi

#Grundkonfiguration
TEMP="PFAD/ZUR/TEMPORÄREN/DATEI"
MAIL="E-MAIL-ADRESSE"
SUBJECT="Serverstatus"

#Mailtext
date > $TEMP
hostname >> $TEMP
uname -a >> $TEMP
echo "" >> $TEMP
echo "Sensoren:" >> $TEMP
echo "" >> $TEMP
sensors >> $TEMP
echo "-----" >> $TEMP
echo "" >> $TEMP
echo "Festplattenspeicher" >> $TEMP
df -h >> $TEMP
echo "-----" >> $TEMP
echo "" >> $TEMP
echo "Uptime" >> $TEMP
uptime >> $TEMP
echo "-----" >> $TEMP
echo "" >> $TEMP
echo "Status Webserver" >> $TEMP
systemctl status apache2 >> $TEMP
echo "-----" >> $TEMP
echo "Status Mailserver" >> $TEMP
systemctl status postfix >> $TEMP
echo "" >> $TEMP
echo "IP-Addresse" >> $TEMP
ip addr >> $TEMP
echo "-----" >> $TEMP
echo "" >> $TEMP
echo "Netzwerkerreichberkeit" >> $TEMP
ping -c 2 startpage.com >> $TEMP
echo "-----" >> $TEMP
echo "" >> $TEMP

#Mail versenden
mail -s $SUBJECT $MAIL < $TEMP

#Temporaere Datei löschen
rm $TEMP
