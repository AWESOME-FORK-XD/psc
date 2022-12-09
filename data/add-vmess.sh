#!/bin/bash

# ENV
domain=$(cat /etc/adi/domain)
porttls="443"
portnontls="80"
fix=%26
# Read User Info
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
	read -rp "User: " -e user
	CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/netz/vmessws.json | wc -l)
	if [[ ${CLIENT_EXISTS} == '2' ]]; then
			echo ""
			echo "User ini telah ada, Tolong gunakan nama lain."
			exit 1
	fi
done
uuid=$(xray uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
# Buat Akun
# WS TLS
sed -i '/#membervmessws$/a\### '"$user $exp"'},{"email": ''"'"$user"'"'',"id": ''"'"$uuid"'"'', "alterId": 0' /usr/local/etc/xray/netz/vmessws.json
# WS NON TLS
sed -i '/#membervmesswsnon$/a\### '"$user $exp"'},{"email": ''"'"$user"'"'',"id": ''"'"$uuid"'"'', "alterId": 0' /usr/local/etc/xray/netz/vmesswsnon.json
# WS NON TLS ORBIT
sed -i '/#membervmesskuotahabis$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"id": ''"'"$uuid"'"'', "alterId": 0' /usr/local/etc/xray/netz/vmesskuota.json
# GRPC
sed -i '/#membervmessgrpc$/a\### '"$user $exp"'},{"email": ''"'"$user"'"'',"id": ''"'"$uuid"'"''' /usr/local/etc/xray/netz/vmessgrpc.json
# Encrypt Method
# WS TLS
cat>/etc/adi/vmess/$user-membervmessws.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${porttls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/netzvmess",
      "type": "none",
      "host": "",
      "tls": "tls"
	  }
EOF
# WS NON TLS
cat>/etc/adi/vmess/$user-membervmesswsnon.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${portnontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/netzvmess",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
	  }
EOF
# WS NON TLS
cat>/etc/adi/vmess/$user-membervmesskuotahabis.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${portnontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/kuota-habis/netzvmess",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
	  }
EOF
# GRPC
cat>/etc/adi/vmess/$user-membervmessgrpc.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${porttls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "netzvmessgrpc",
      "type": "gun",
      "host": "",
      "tls": "tls"
	  }
EOF
# Converter Vmess
vmessws="vmess://$(base64 -w 0 /etc/adi/vmess/$user-membervmessws.json)"
vmesswsnon="vmess://$(base64 -w 0 /etc/adi/vmess/$user-membervmesswsnon.json)"
vmesskuota="vmess://$(base64 -w 0 /etc/adi/vmess/$user-membervmesskuotahabis.json)"
vmessgrpc="vmess://$(base64 -w 0 /etc/adi/vmess/$user-membervmessgrpc.json)"
# Cleanup
clear
# Post Telegram
if [[ -z $BOT_TOKEN ]]; then
	echo "Terimakasih Telah Menggunakan Layanan NetzXRay Bot"
elif [[ -z $CHAT_ID ]]; then
	echo -e " "
else
tg_send_message --chat_id "$CHAT_ID" --text "*VMESS BERHASIL DIBUAT !*
*ISP*   : $ISP
*IP*    : $IPADRESS
*Domain*        : $domain
*Client*        : $user
*UUID*  : $uuid
*Aktif Sampai* : $exp
VMESS
Vmess WS TLS    : \`$vmessws\`
Vmess WS NON    : \`$vmesswsnon\`
Vmess ORBIT     : \`$vmesskuota\`
Vmess GRPC TLS  : \`$vmessgrpc\`
AutoScript By Adi Subagja" --parse_mode "Markdown" >/dev/null
echo "Terimakasih Telah Menggunakan Layanan NetzXRay"
fi
# Informasi Akun
echo -e XRAY/VMESS
echo -e Remarks     : "$user"
echo -e UUID        : "$uuid"
echo -e Domain      : "$domain"
echo -e Port        : "$porttls & $portnontls"
echo -e Masa Aktif  : "$exp"
echo -e Path        : "/netzvmess"
echo -e Path Orbit  : "/kuota-habis/netzvmess"
echo -e ServiceName : "netzvmessgrpc"
echo -e
echo -e WS TLS      : "$vmessws"
echo -e ""
echo -e
echo -e WS NON      : "$vmesswsnon"
echo -e ""
echo -e
echo -e ORBIT       : "$vmesskuota"
echo -e ""
echo -e
echo -e GRPC        : "$vmessgrpc"
echo -e ""
echo -e
echo -e NO TORRENT
echo -e NO SEEDING
echo -e NO MULTILOGIN
echo -e
# Trigger Reload Services
echo -e "Halaman akan ditutup dalam 5-10 detik"
sleep 10
systemctl restart xray
clear
echo -e "Sucessfully Created"
welcome
