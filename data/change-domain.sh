#!/bin/bash

clear
# PKG
apt update && upgrade
apt install git -y
# Remove Necesarry Files
rm -f /etc/adi/adi.crt
rm -f /etc/adi/adi.key
rm -f /etc/adi/domain
rm -f /root/domain
# Command
echo "Masukan Domain Baru Kamu"
read -p "Hostname / Domain: " host
echo "$host" >> /etc/adi/domain
echo "$host" >> /root/domain
# ENV
domain=$(cat /root/domain)
# Clone Acme
ufw disable
git clone https://github.com/acmesh-official/acme.sh.git /etc/acme
cd /etc/acme
systemctl stop nginx
systemctl stop xray
chmod +x acme.sh
./acme.sh --set-default-ca --server letsencrypt
./acme.sh --register-account -m netz@$domain
./acme.sh --issue -d $domain --standalone --server letsencrypt --force
./acme.sh --installcert -d $domain --key-file /etc/adi/adi.key --fullchain-file /etc/adi/adi.crt
# Restart Service
rm -f /root/domain
systemctl restart nginx
systemctl restart xray
echo "Domain Telah Diperbarui & Sertifikasi Selesai"
