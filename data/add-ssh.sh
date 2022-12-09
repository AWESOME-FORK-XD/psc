#!/bin/bash

clear
domain=$(cat /etc/adi/domain)
porttls="443"
portnontls="80"
fix=%26
# Get InfoName
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif
sleep 1
clear
# Setup Account
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
# Informasi Telegram
# Post Telegram
if [[ -z $BOT_TOKEN ]]; then
	echo "Terimakasih Telah Menggunakan Layanan NetzXRay Bot"
elif [[ -z $CHAT_ID ]]; then
	echo -e " "
else
tg_send_message --chat_id "$CHAT_ID" --text "*SSH BERHASIL DIBUAT !*
*ISP*   : $ISP
*IP*    : $IPADRESS
*Domain*        : $domain
Username = $Login
Password = $Pass
Masa Aktif = $exp
SSH Dropbear = 143
SSH SSL = 443,445
SSH WS = 80,8880
SSH WS SSL = 443
OPENVPN TCP = 1194
OPENVPN UDP = 2200
OPENVPN SSL = 442
UDPGW = 7300
OVPN TCP = http://$domain:81/openvpn/TCP.ovpn
OVPN UDP = http://$domain:81/openvpn/UDP.ovpn
OVPN SSL = http://$domain:81/openvpn/SSL.ovpn
Payload SSH WS = \`GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf]Connection: Keep-Alive[crlf][crlf]\`
Payload SSH WS SSL = \`GET wss://bug.com/ [protocol][crlf]Host: $domain[crlf]Upgrade: websocket[crlf]Connection: Keep-Alive[crlf][crlf]\`
AutoScript By Adi Subagja" --parse_mode "Markdown" >/dev/null
echo "Terimakasih Telah Menggunakan Layanan NetzXRay"
fi
# Informasi Akun CLI
echo -e "
Terima Kasih !
Akun SSH Telah Dibuat
IP = $IPADRESS
Domain = $domain
Username = $Login
Password = $Pass
Masa Aktif = $exp
SSH Dropbear = 143
SSH SSL = 443,445
SSH WS = 80,8880
SSH WS SSL = 443
OPENVPN TCP = 1194
OPENVPN UDP = 2200
OPENVPN SSL = 442
UDPGW = 7300
OVPN TCP = http://$domain:81/openvpn/TCP.ovpn
OVPN UDP = http://$domain:81/openvpn/UDP.ovpn
OVPN SSL = http://$domain:81/openvpn/SSL.ovpn
Payload SSH WS = GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf]Connection: Keep-Alive[crlf][crlf]
Payload SSH WS SSL = GET wss://bug.com/ [protocol][crlf]Host: $domain[crlf]Upgrade: websocket[crlf]Connection: Keep-Alive[crlf][crlf]
"
