#!/bin/bash

export PASSWORD=`cat /etc/kolla/passwords.yml|grep "^database_password"|cut -d":" -f2| sed -e 's/^[ \t]*//'`
export IP=`cat /etc/kolla/globals.yml|grep '^kolla_internal_vip_address'|cut -d":" -f2| sed -e 's/^[ \t]*//' -e 's/^"//' -e 's/"$//' `

mysql -u root -p$PASSWORD -h $IP
