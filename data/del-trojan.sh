#!/bin/bash

clear
echo ""
echo " Select the existing client you want to remove"
echo " Press CTRL+C to return"
echo " ==============================="
echo "     No  Expired   User"
grep -E "^### " "/usr/local/etc/xray/netz/trojantcp.json" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
	if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
	else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
	fi
done
user=$(grep -E "^### " "/usr/local/etc/xray/netz/trojantcp.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/etc/xray/netz/trojantcp.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojantcp.json
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojantcpnon.json
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojanws.json
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojanwsnon.json
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojankuota.json
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojangrpc.json
rm -f /root/akun/trojan/$user.txt
systemctl restart xray
clear
echo " Akun Berhasil Dihapus"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="
