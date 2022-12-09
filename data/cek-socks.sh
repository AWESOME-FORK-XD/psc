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
data=( `cat /usr/local/etc/xray/netz/socksws.json | grep '^###' | cut -d ' ' -f 2`);
#echo "-------------------------------";
#echo "-----=[ SS WS Login ]=-----";
#echo "-------------------------------";
for akun in "${data[@]}"; do
	if [[ -z "$akun" ]]; then
		akun="tidakada"
		echo -n > /tmp/ipsocksws.txt
		data2=( `cat /var/log/adi/access.log | tail -n 500 | awk '{print $3}' | cut -d: -f1 | grep -v 127.0.0.1 | grep -v tcp | sort | uniq`);
		for ip in "${data2[@]}"; do
			jum=$(cat /var/log/adi/access.log | grep SOCKSWS | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | grep -v 127.0.0.1 | sort | uniq)
			if [[ "$jum" = "$ip" ]]; then
				echo "$jum" >> /tmp/ipsocksws.txt
			else
				echo "$ip" >> /tmp/other.txt
				jum2=$(cat /tmp/ipsocksws.txt)
				sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
			fi
		done
	fi
	jum=$(cat /tmp/ipsocksws.txt)
	if [[ -z "$jum" ]]; then
		echo > /dev/null
	else
		jum2=$(cat /tmp/ipsocksws.txt | nl)
		echo "-------------------------------";
		echo "-----=[ SOCKS WS Login ]=-----";
		echo "-------------------------------";
		echo "user : $akun";
		echo "$jum2";
		echo "-------------------------------"
		rm -rf /tmp/ipsocksws.txt
	fi
done
# SS WS NON
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/netz/sockswsnon.json | grep '^###' | cut -d ' ' -f 2`);
#echo "-------------------------------";
#echo "-----=[ ss WS NON Login ]=-----";
#echo "-------------------------------";
for akun in "${data[@]}"; do
	if [[ -z "$akun" ]]; then
		akun="tidakada"
		echo -n > /tmp/ipsockswsnon.txt
		data2=( `cat /var/log/adi/access.log | tail -n 500 | awk '{print $3}' | cut -d: -f1 | grep -v 127.0.0.1 | grep -v tcp | sort | uniq`);
		for ip in "${data2[@]}"; do
			jum=$(cat /var/log/adi/access.log | grep SOCKSWSNON | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | grep -v 127.0.0.1 | sort | uniq)
			if [[ "$jum" = "$ip" ]]; then
				echo "$jum" >> /tmp/ipsockswsnon.txt
			else
				echo "$ip" >> /tmp/other.txt
				jum2=$(cat /tmp/ipsockswsnon.txt)
				sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
			fi
		done
	fi
	jum=$(cat /tmp/ipsockswsnon.txt)
	if [[ -z "$jum" ]]; then
		echo > /dev/null
	else
		jum2=$(cat /tmp/ipsockswsnon.txt | nl)
		echo "-------------------------------";
		echo "-----=[ SOCKS WS NON Login ]=-----";
		echo "-------------------------------";
		echo "user : $akun";
		echo "$jum2";
		echo "-------------------------------"
		rm -rf /tmp/ipsockswsnon.txt
	fi
done
# SS GRPC
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/netz/socksgrpc.json | grep '^###' | cut -d ' ' -f 2`);
#echo "-------------------------------";
#echo "-----=[ SS GRPC Login ]=-----";
#echo "-------------------------------";
for akun in "${data[@]}"; do
	if [[ -z "$akun" ]]; then
	akun="tidakada"
		echo -n > /tmp/ipsocksgrpc.txt
		data2=( `cat /var/log/adi/access.log | tail -n 500 | awk '{print $3}' | cut -d: -f1 | grep -v 127.0.0.1 | grep -v tcp | sort | uniq`);
		for ip in "${data2[@]}"; do
			jum=$(cat /var/log/adi/access.log | grep SOCKSGRPC | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | grep -v 127.0.0.1 | sort | uniq)
			if [[ "$jum" = "$ip" ]]; then
				echo "$jum" >> /tmp/ipsocksgrpc.txt
			else
				echo "$ip" >> /tmp/other.txt
				jum2=$(cat /tmp/ipsocksgrpc.txt)
				sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
			fi
		done
	fi
	jum=$(cat /tmp/ipsocksgrpc.txt)
	if [[ -z "$jum" ]]; then
		echo > /dev/null
	else
		jum2=$(cat /tmp/ipsocksgrpc.txt | nl)
		echo "-------------------------------";
		echo "-----=[ SOCKS GRPC Login ]=-----";
		echo "-------------------------------";
		echo "user : $akun";
		echo "$jum2";
		echo "-------------------------------"
		rm -rf /tmp/ipsocksgrpc.txt
	fi
done
rm -rf /tmp/other.txt
