#!/bin/bash

# ENV
domain=$(cat /etc/adi/domain)
porttls="443"
portnontls="80"
fix=%26
# Read User Info
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
	read -rp "User: " -e user
	CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/netz/trojantcp.json | wc -l)
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
# TCP TLS
sed -i '/#membertrojantcp$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"password": ''"'"$user"'"''' /usr/local/etc/xray/netz/trojantcp.json
# TCP NON TLS
sed -i '/#membertrojantcpnon$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"password": ''"'"$user"'"''' /usr/local/etc/xray/netz/trojantcpnon.json
# WS TLS
sed -i '/#membertrojanws$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"password": ''"'"$user"'"''' /usr/local/etc/xray/netz/trojanws.json
# WS NON TLS
sed -i '/#membertrojanwsnon$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"password": ''"'"$user"'"''' /usr/local/etc/xray/netz/trojanwsnon.json
# WS NON TLS ORBIT
sed -i '/#membertrojankuotahabis$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"password": ''"'"$user"'"''' /usr/local/etc/xray/netz/trojankuota.json
# GRPC
sed -i '/#membertrojangrpc$/a\### '"$user $exp"'\
},{"email": ''"'"$user"'"'',"password": ''"'"$user"'"''' /usr/local/etc/xray/netz/trojangrpc.json
# Converted
trojantcp="trojan://${user}@${domain}:$porttls?security=tls&headerType=none&type=tcp#${user}"
trojanws="trojan://${user}@${domain}:$porttls?path=/netztrojan&security=tls&type=ws#${user}"
trojanwsnon="trojan://${user}@${domain}:$portnontls?path=/netztrojan&security=none&encryption=none&type=ws&host=${domain}#${user}"
trojankuota="trojan://${user}@${domain}:$portnontls?path=/kuota-habis/netztrojan&security=none&encryption=none&type=ws&host=${domain}#${user}"
trojangrpc="trojan://${user}@${domain}:$porttls?mode=gun&security=tls&type=grpc&serviceName=netztrojangrpc#${user}"
# Converted Telegram
trojantcptelegram="trojan://${user}@${domain}:$porttls?security=tls${fix}headerType=none${fix}type=tcp#${user}"
trojanwstelegram="trojan://${user}@${domain}:$porttls?path=/netztrojan${fix}security=tls${fix}type=ws#${user}"
trojanwsnontelegram="trojan://${user}@${domain}:$portnontls?path=/netztrojan${fix}security=none${fix}encryption=none${fix}type=ws${fix}host=${domain}#${user}"
trojankuotatelegram="trojan://${user}@${domain}:$portnontls?path=/kuota-habis/netztrojan${fix}security=none${fix}encryption=none${fix}type=ws${fix}host=${domain}#${user}"
trojangrpctelegram="trojan://${user}@${domain}:$porttls?mode=gun${fix}security=tls${fix}type=grpc${fix}serviceName=netztrojangrpc#${user}"
# Cleanup
clear
# Post Telegram
if [[ -z $BOT_TOKEN ]]; then
	echo "Terimakasih Telah Menggunakan Layanan NetzXRay Bot"
elif [[ -z $CHAT_ID ]]; then
	echo -e " "
else
tg_send_message --chat_id "$CHAT_ID" --text "*TROJAN BERHASIL DIBUAT !*
*ISP*   : $ISP
*IP*    : $IPADRESS
*Domain*        : $domain
*Client*        : $user
*Password*      : $user
*Aktif Sampai* : $exp
TROJAN
TROJAN TCP TLS  : \`$trojantcptelegram\`
TROJAN WS TLS   : \`$trojanwstelegram\`
TROJAN NON TLS  : \`$trojanwsnontelegram\`
TROJAN ORBIT    : \`$trojankuotatelegram\`
TROJAN GRPC TLS : \`$trojangrpctelegram\`
AutoScript By Adi Subagja" --parse_mode "Markdown" >/dev/null
echo "Terimakasih Telah Menggunakan Layanan NetzXRay"
fi
# Informasi Akun
echo -e
XRAY/TROJAN
echo -e Remarks     : "$user"
echo -e Password    : "$user"
echo -e Domain      : "$domain"
echo -e Port        : "$porttls & $portnontls"
echo -e Masa Aktif  : "$exp"
echo -e Path        : "/netztrojan"
echo -e Path Orbit      : "/kuota-habis/netztrojan"
echo -e ServiceName : "netztrojangrpc"
echo -e
echo -e TCP TLS     : "$trojantcp"
echo -e ""
echo -e
echo -e WS TLS      : "$trojanws"
echo -e ""
echo -e
echo -e WS NON      : "$trojanwsnon"
echo -e ""
echo -e
echo -e ORBIT       : "$trojankuota"
echo -e ""
echo -e
echo -e GRPC        : "$trojangrpc"
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
