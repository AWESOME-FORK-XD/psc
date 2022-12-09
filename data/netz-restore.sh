#!/bin/bash

clear
# Initialize Restore
# Nama
echo -e "Masukan Nama Yang Telah Tersimpan"
read -rp "Masukan Nama : " -e NamaMu
if [[ -z $NamaMu ]]; then
	exit 0
fi
# Pass
echo -e "Masukan Password Yang Telah Tersimpan"
read -rp "Masukan Password : " -e PassKamu
if [[ -z $PassKamu ]]; then
	exit 0
fi
# Tanggal
echo -e "Masukan Tanggal Tersimpan"
read -rp "Masukan Tanggal : " -e TanggalMu
if [[ -z $TanggalMu ]]; then
	exit 0
fi
echo -e "Processing... "
# Logical Test File
NETZ_UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"
HEADER="--header X-Forwarded-For:$XIP"
# Write code
result=$(curl $HEADER --user-agent "${NETZ_UA}" -fsL --write-out %{http_code} --output /dev/null --max-time 10 "http://cloud.adinetworks.eu.org/$TanggalMu/$NamaMu-$TanggalMu.zip")
if [ "$result" = "404" ]; then
	echo -e "${red}Data kamu tidak ada di Netz-Backup${NC}"
	exit 0
elif [ "$result" = "000" ]; then
	echo -e "${red}Maintenance Sabar Ya...${NC}"
	exit 0
elif [ "$result" = "200" ]; then
echo -e "${green}Data Kamu Tersedia Di Netz-Backup${NC}"
# Link
cd /root
get_link=https://cloud.adinetworks.eu.org/$TanggalMu/$NamaMu-$TanggalMu.zip
wget -q $get_link
cekpassword=$(unzip -qq -t -P $PassKamu /root/$NamaMu-$TanggalMu.zip)
passresult="$?"
if [[ $passresult = "1" ]]; then
	echo -e "${red}Password Kamu Salah !!!${NC}"
	rm -rf /root/$NamaMu-$TanggalMu.zip
	exit 0
elif [[ $passresult = "0" ]]; then
unzip -qq -P $PassKamu /root/$NamaMu-$TanggalMu.zip -d /root
# COPYING FILES
cp /root/backup/passwd /etc/
cp /root/backup/group /etc/
cp /root/backup/shadow /etc/
cp /root/backup/gshadow /etc/
cp /root/backup/netz/* /usr/local/etc/xray/netz
# CLEARING
rm -rf /root/$NamaMu-$TanggalMu.zip
rm -rf /root/backup
# Restart Service
systemctl restart xray
# Pesan
echo -e "Data Telah Dipulihkan
================================
User    : $NamaMu
Pass    : $PassKamu
Tgl     : $TanggalMu
================================
Terima Kasih Telah Menggunakan Layanan NetzXray"
fi
