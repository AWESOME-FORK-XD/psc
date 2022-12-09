#!/bin/bash

# Trojan TCP
data=( `cat /usr/local/etc/xray/netz/trojantcp.json | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
	exp=$(grep -w "^### $user" "/usr/local/etc/xray/netz/trojantcp.json" | cut -d ' ' -f 3)
	d1=$(date -d "$exp" +%s)
	d2=$(date -d "$now" +%s)
	exp2=$(( (d1 - d2) / 86400 ))
	if [[ "$exp2" = "0" ]]; then
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojantcp.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojantcpnon.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojanws.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojanwsnon.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojankuota.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/trojangrpc.json
	fi
done
echo TROJAN EXPIRED TERHAPUS
# Vless WS
data=( `cat /usr/local/etc/xray/netz/vlessws.json | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
	exp=$(grep -w "^### $user" "/usr/local/etc/xray/netz/vlessws.json" | cut -d ' ' -f 3)
	d1=$(date -d "$exp" +%s)
	d2=$(date -d "$now" +%s)
	exp2=$(( (d1 - d2) / 86400 ))
	if [[ "$exp2" = "0" ]]; then
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/vlessws.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/vlesswsnon.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/vlesskuota.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/vlessgrpc.json
	fi
done
echo VLESS EXPIRED TERHAPUS
# Vmess WS
data=( `cat /usr/local/etc/xray/netz/vmessws.json | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
	exp=$(grep -w "^### $user" "/usr/local/etc/xray/netz/vmessws.json" | cut -d ' ' -f 3)
	d1=$(date -d "$exp" +%s)
	d2=$(date -d "$now" +%s)
	exp2=$(( (d1 - d2) / 86400 ))
	if [[ "$exp2" = "0" ]]; then
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/vmessws.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/vmesswsnon.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/vmesskuota.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/vmessgrpc.json
		rm -f /etc/adi/vmess/$user-membervmessws.json
	fi
done
echo VMESS EXPIRED TERHAPUS
# ShadowSocks WS
data=( `cat /usr/local/etc/xray/netz/ssws.json | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
	exp=$(grep -w "^### $user" "/usr/local/etc/xray/netz/ssws.json" | cut -d ' ' -f 3)
	d1=$(date -d "$exp" +%s)
	d2=$(date -d "$now" +%s)
	exp2=$(( (d1 - d2) / 86400 ))
	if [[ "$exp2" = "0" ]]; then
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/ssws.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/sswsnon.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/sskuota.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/sswsgrpc.json
	fi
done
echo SHADOWSOCKS EXPIRED TERHAPUS
# Shadowsocks 2022 WS
data=( `cat /usr/local/etc/xray/netz/ssblakews.json | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
	exp=$(grep -w "^### $user" "/usr/local/etc/xray/netz/ssblakews.json" | cut -d ' ' -f 3)
	d1=$(date -d "$exp" +%s)
	d2=$(date -d "$now" +%s)
	exp2=$(( (d1 - d2) / 86400 ))
	if [[ "$exp2" = "0" ]]; then
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/ssblakews.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/ssblakewsnon.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/ssblakekuota.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/ssblakegrpc.json
	fi
done
echo SHADOWSOCKS 2022 EXPIRED TERHAPUS
# SOCKS5 WS
data=( `cat /usr/local/etc/xray/netz/socksws.json | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
	exp=$(grep -w "^### $user" "/usr/local/etc/xray/netz/socksws.json" | cut -d ' ' -f 3)
	d1=$(date -d "$exp" +%s)
	d2=$(date -d "$now" +%s)
	exp2=$(( (d1 - d2) / 86400 ))
	if [[ "$exp2" = "0" ]]; then
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/socksws.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/sockswsnon.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/sockskuota.json
		sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/netz/socksgrpc.json
	fi
done
echo SOCKS5 EXPIRED TERHAPUS
systemctl restart xray
