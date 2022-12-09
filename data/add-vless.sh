#!/bin/bash

# ENV
domain=$(cat /etc/adi/domain)
porttls="443"
portnontls="80"
fix=%26
# Read User Info
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
	read -rp "User: " -e user
	CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/netz/vlessws.json | wc -l)
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
sed -i '/#membervlessws$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"id": ''"'"$uuid"'"'', "alterId": 0' /usr/local/etc/xray/netz/vlessws.json
# WS NON TLS
sed -i '/#membervlesswsnon$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"id": ''"'"$uuid"'"'', "alterId": 0' /usr/local/etc/xray/netz/vlesswsnon.json
# WS NON TLS ORBIT
sed -i '/#membervlesskuotahabis$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"id": ''"'"$uuid"'"'', "alterId": 0' /usr/local/etc/xray/netz/vlesskuota.json
# GRPC
sed -i '/#membervlessgrpc$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"id": ''"'"$uuid"'"''' /usr/local/etc/xray/netz/vlessgrpc.json
# Converted
vlessws="vless://${uuid}@${domain}:$porttls?path=/netzvless&security=tls&encryption=none&type=ws#${user}"
vlesswsnon="vless://${uuid}@${domain}:$portnontls?path=/netzvless&security=none&encryption=none&type=ws&host=${domain}#${user}"
vlesskuota="vless://${uuid}@${domain}:$portnontls?path=/kuota-habis/netzvless&security=none&encryption=none&type=ws&host=${domain}#${user}"
vlessgrpc="vless://${uuid}@${domain}:$porttls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=netzvlessgrpc#${user}"
# Converted Telegram
vlesswstelegram="vless://${uuid}@${domain}:$porttls?path=/netzvless${fix}security=tls${fix}encryption=none${fix}type=ws#${user}"
vlesswsnontelegram="vless://${uuid}@${domain}:$portnontls?path=/netzvless${fix}security=none${fix}encryption=none${fix}type=ws${fix}host=${domain}#${user}"
vlesskuotatelegram="vless://${uuid}@${domain}:$portnontls?path=/kuota-habis/netzvless${fix}security=none${fix}encryption=none${fix}type=ws${fix}host=${domain}#${user}"
vlessgrpctelegram="vless://${uuid}@${domain}:$porttls?mode=gun${fix}security=tls${fix}encryption=none${fix}type=grpc${fix}serviceName=netzvlessgrpc#${user}"
# Cleanup
clear
# Post Telegram
if [[ -z $BOT_TOKEN ]]; then
	echo "Terimakasih Telah Menggunakan Layanan NetzXRay Bot"
elif [[ -z $CHAT_ID ]]; then
	echo -e " "
else
tg_send_message --chat_id "$CHAT_ID" --text "*VLESS BERHASIL DIBUAT !*
*ISP*   : $ISP
*IP*    : $IPADRESS
*Domain*        : $domain
*Client*        : $user
*UUID*  : $uuid
*Aktif Sampai* : $exp
VLESS
VLESS WS TLS    : \`$vlesswstelegram\`
VLESS WS NON    : \`$vlesswsnontelegram\`
VLESS ORBIT     : \`$vlesskuotatelegram\`
VLESS GRPC TLS  : \`$vlessgrpctelegram\`
AutoScript By Adi Subagja" --parse_mode "Markdown" >/dev/null
echo "Terimakasih Telah Menggunakan Layanan NetzXRay"
fi
# Informasi Akun
echo -e
XRAY/VLESS
echo -e Remarks     : "$user"
echo -e UUID        : "$uuid"
echo -e Domain      : "$domain"
echo -e Port        : "$porttls & $portnontls"
echo -e Masa Aktif  : "$exp"
echo -e Path        : "/netzvless"
echo -e Path Orbit      : "/kuota-habis/netzvless"
echo -e ServiceName : "netzvlessgrpc"
echo -e
echo -e WS TLS      : "$vlessws"
echo -e ""
echo -e
echo -e WS NON      : "$vlesswsnon"
echo -e ""
echo -e
echo -e ORBIT       : "$vlesskuota"
echo -e ""
echo -e
echo -e GRPC        : "$vlessgrpc"
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
