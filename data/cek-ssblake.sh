#!/bin/bash

clear
#GET CLIENT NAME
# vmess TCP
#echo -n > /tmp/other.txt
#data=( `cat /usr/local/etc/xray/netz/vmesstcp.json | grep '^###' | cut -d ' ' -f 2`);
#echo "-------------------------------";
#echo "-----=[ vmess TCP Login ]=-----";
#echo "-------------------------------";
#for akun in "${data[@]}"
#if [[ -z "$akun" ]]; then
#akun="tidakada"
#echo -n > /tmp/ipvmesstcp.txt
#data2=( `cat /var/log/adi/access.log | tail -n 500 | awk '{print $3}' | cut -d: -f1 | grep -v 127.0.0.1 | grep -v tcp | sort | uniq`);
#for ip in "${data2[@]}"
#jum=$(cat /var/log/adi/access.log | grep vmessTCP | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | grep -v 127.0.0.1 | sort | uniq)
#if [[ "$jum" = "$ip" ]]; then
#echo "$jum" >> /tmp/ipvmesstcp.txt
#else
#echo "$ip" >> /tmp/other.txt
#jum2=$(cat /tmp/ipvmesstcp.txt)
#sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
#done
#jum=$(cat /tmp/ipvmesstcp.txt)
#if [[ -z "$jum" ]]; then
#echo > /dev/null
#else
#jum2=$(cat /tmp/ipvmesstcp.txt | nl)
#echo "-------------------------------";
#echo "-----=[ vmess TCP Login ]=-----";
#echo "-------------------------------";
#echo "user : $akun";
#echo "$jum2";
#echo "-------------------------------"
#rm -rf /tmp/ipvmesstcp.txt
#done
#oth=$(cat /tmp/other.txt | sort | uniq | nl)
#echo "other";
#echo "$oth";
#echo "-------------------------------"
# SS WS
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/netz/ssblakews.json | grep '^###' | cut -d ' ' -f 2`);
#echo "-------------------------------";
#echo "-----=[ SS WS Login ]=-----";
#echo "-------------------------------";
for akun in "${data[@]}"; do
	if [[ -z "$akun" ]]; then
		akun="tidakada"
		echo -n > /tmp/ipssblakews.txt
		data2=( `cat /var/log/adi/access.log | tail -n 500 | awk '{print $3}' | cut -d: -f1 | grep -v 127.0.0.1 | grep -v tcp | sort | uniq`);
		for ip in "${data2[@]}"; do
			jum=$(cat /var/log/adi/access.log | grep SSBLAKEWS | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | grep -v 127.0.0.1 | sort | uniq)
			if [[ "$jum" = "$ip" ]]; then
				echo "$jum" >> /tmp/ipssblakews.txt
			else
				echo "$ip" >> /tmp/other.txt
				jum2=$(cat /tmp/ipssblakews.txt)
				sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
			fi
		done
	fi
	jum=$(cat /tmp/ipssblakews.txt)
	if [[ -z "$jum" ]]; then
		echo > /dev/null
	else
		jum2=$(cat /tmp/ipssblakews.txt | nl)
		echo "-------------------------------";
		echo "-----=[ SS WS22 Login ]=-----";
		echo "-------------------------------";
		echo "user : $akun";
		echo "$jum2";
		echo "-------------------------------"
		rm -rf /tmp/ipssblakews.txt
	fi
done
# SS WS NON
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/netz/ssblakewsnon.json | grep '^###' | cut -d ' ' -f 2`);
#echo "-------------------------------";
#echo "-----=[ ss WS NON Login ]=-----";
#echo "-------------------------------";
for akun in "${data[@]}"; do
	if [[ -z "$akun" ]]; then
		akun="tidakada"
		echo -n > /tmp/ipssblakewsnon.txt
		data2=( `cat /var/log/adi/access.log | tail -n 500 | awk '{print $3}' | cut -d: -f1 | grep -v 127.0.0.1 | grep -v tcp | sort | uniq`);
		for ip in "${data2[@]}"; do
			jum=$(cat /var/log/adi/access.log | grep SSBLAKEWSNON | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | grep -v 127.0.0.1 | sort | uniq)
			if [[ "$jum" = "$ip" ]]; then
				echo "$jum" >> /tmp/ipssblakewsnon.txt
			else
				echo "$ip" >> /tmp/other.txt
				jum2=$(cat /tmp/ipssblakewsnon.txt)
				sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
			fi
		done
	fi
	jum=$(cat /tmp/ipssblakewsnon.txt)
	if [[ -z "$jum" ]]; then
		echo > /dev/null
	else
		jum2=$(cat /tmp/ipssblakewsnon.txt | nl)
		echo "-------------------------------";
		echo "-----=[ SS22 WS NON Login ]=-----";
		echo "-------------------------------";
		echo "user : $akun";
		echo "$jum2";
		echo "-------------------------------"
		rm -rf /tmp/ipssblakewsnon.txt
	fi
done
# SS GRPC
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/netz/ssblakegrpc.json | grep '^###' | cut -d ' ' -f 2`);
#echo "-------------------------------";
#echo "-----=[ SS GRPC Login ]=-----";
#echo "-------------------------------";
for akun in "${data[@]}"; do
	if [[ -z "$akun" ]]; then
		akun="tidakada"
		echo -n > /tmp/ipssblakegrpc.txt
		data2=( `cat /var/log/adi/access.log | tail -n 500 | awk '{print $3}' | cut -d: -f1 | grep -v 127.0.0.1 | grep -v tcp | sort | uniq`);
		for ip in "${data2[@]}"; do
			jum=$(cat /var/log/adi/access.log | grep SSBLAKEGRPC | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | grep -v 127.0.0.1 | sort | uniq)
			if [[ "$jum" = "$ip" ]]; then
				echo "$jum" >> /tmp/ipssblakegrpc.txt
			else
				echo "$ip" >> /tmp/other.txt
				jum2=$(cat /tmp/ipssblakegrpc.txt)
				sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
			fi
		done
	fi
	jum=$(cat /tmp/ipssblakegrpc.txt)
	if [[ -z "$jum" ]]; then
		echo > /dev/null
	else
		jum2=$(cat /tmp/ipssblakegrpc.txt | nl)
		echo "-------------------------------";
		echo "-----=[ SS22 GRPC Login ]=-----";
		echo "-------------------------------";
		echo "user : $akun";
		echo "$jum2";
		echo "-------------------------------"
		rm -rf /tmp/ipssblakegrpc.txt
	fi
done
rm -rf /tmp/other.txt
