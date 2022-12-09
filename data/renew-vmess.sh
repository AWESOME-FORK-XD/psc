#!/bin/bash

clear
echo ""
echo "Select the existing client you want to renew"
echo " Press CTRL+C to return"
echo -e "==============================="
grep -E "^### " "/usr/local/etc/xray/netz/vmessws.json" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
	if [[ ${CLIENT_NUMBER} == '2' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
	else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
	fi
done
read -p "Expired (days): " masaaktif
user=$(grep -E "^### " "/usr/local/etc/xray/netz/vmessws.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/etc/xray/netz/vmessws.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/netz/vmessws.json
sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/netz/vmesswsnon.json
sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/netz/vmesskuota.json
sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/netz/vmessgrpc.json
service cron restart
clear
echo ""
echo " VMESS Berhasil Diperpanjang !"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " =========================="
