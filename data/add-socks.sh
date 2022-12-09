#!/bin/bash

# ENV
domain=$(cat /etc/adi/domain)
porttls="443"
portnontls="80"
fix=%26
# Read User Info
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/netz/socksws.json | wc -l)
		if [[ ${CLIENT_EXISTS} == '2' ]]; then
				echo ""
				echo "User ini telah ada, Tolong gunakan nama lain."
				exit 1
		fi
done
uuid=$(xray uuid)
genpas=$()
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
# Buat Akun
# WS TLS
sed -i '/#membersocksws$/a\### '"$user $exp"'\
},{"user": ''"'"$user"'"'',"pass": ''"'"$user"'"''' /usr/local/etc/xray/netz/socksws.json
# WS NON TLS
sed -i '/#membersockswsnon$/a\### '"$user $exp"'\
},{"user": ''"'"$user"'"'',"pass": ''"'"$user"'"''' /usr/local/etc/xray/netz/sockswsnon.json
# WS NON TLS ORBIT
sed -i '/#membersockskuotahabis$/a\### '"$user $exp"'\
},{"user": ''"'"$user"'"'',"pass": ''"'"$user"'"''' /usr/local/etc/xray/netz/sockskuota.json
# GRPC
sed -i '/#membersocksgrpc$/a\### '"$user $exp"'\
},{"user": ''"'"$user"'"'',"pass": ''"'"$user"'"''' /usr/local/etc/xray/netz/socksgrpc.json
# OUTLINE
sed -i '/#membersocksoutline$/a\### '"$user $exp"'\
},{"user": ''"'"$user"'"'',"pass": ''"'"$user"'"''' /usr/local/etc/xray/netz/socksoutline.json
# Encrypt Technical
encryptor=$(echo -n "${user}:${user}" | base64 -w0)
# Converted
socksws="socks://${encryptor}@${domain}:${porttls}?path=%2Fnetzsocks&security=tls&type=ws#${user}"
sockswsnon="socks://${encryptor}@${domain}:${portnontls}?path=%2Fnetzsocks&security=none&type=ws#${user}"
sockskuota="socks://${encryptor}@${domain}:${portnontls}?path=%2Fkuota-habis%2Fnetzsocks&security=none&type=ws#${user}"
sockgrpc="socks://${encryptor}@${domain}:${porttls}?mode=gun&security=tls&type=grpc&serviceName=netzsocksgrpc#${user}"
# Converted Telegram
sockswstelegram="socks://${encrypt3}@${domain}:${porttls}?path=/netzsocks${fix}security=tls${fix}type=ws#${user}"
sockswsnontelegram="socks://${encrypt3}@${domain}:${portnontls}?path=/netzsocks${fix}security=none${fix}type=ws#${user}"
sockskuotatelegram="socks://${encrypt3}@${domain}:${portnontls}?path=/kuota-habis/netzsocks${fix}security=none${fix}type=ws#${user}"
socksgrpctelegram="socks://${encrypt3}@${domain}:${porttls}?mode=gun${fix}security=tls${fix}type=grpc${fix}serviceName=netzsocksgrpc#${user}"
# Cleanup
clear
# Post Telegram
if [[ -z $BOT_TOKEN ]]; then
	echo "Terimakasih Telah Menggunakan Layanan NetzXRay Bot"
elif [[ -z $CHAT_ID ]]; then
	echo -e " "
else
tg_send_message --chat_id "$CHAT_ID" --text "*SOCKS BERHASIL DIBUAT !*
*ISP*   : $ISP
*IP*    : $IPADRESS
*Domain*        : $domain
*Client*        : $user
*Password*      : $user
*Aktif Sampai*  : $exp
SOCKS
SOCKS WS        : \`$sockswstelegram\`
SOCKS WS NON    : \`$sockswsnontelegram\`
SOCKS ORBIT     : \`$sockskuotatelegram\`
SOCKS GRPC      : \`$socksgrpctelegram\`
AutoScript By @simbah69" --parse_mode "Markdown" >/dev/null
echo "Terimakasih Telah Menggunakan Layanan NetzXRay"
fi
# Informasi Akun
echo -e
XRAY/SOCKS5
echo -e Remarks     : "$user"
echo -e PASS        : "$user"
echo -e Domain      : "$domain"
echo -e Port        : "$porttls & $portnontls"
echo -e Masa Aktif  : "$exp"
echo -e Path        : "/netzsocks"
echo -e Path Orbit  : "/kuota-habis/netzsocks"
echo -e ServiceName : "netzsocksgrpc"
echo -e
echo -e WS TLS      : "$socksws"
echo -e ""
echo -e
echo -e WS NON      : "$sockswsnon"
echo -e ""
echo -e
echo -e ORBIT       : "$sockskuota"
echo -e ""
echo -e
echo -e GRPC        : "$sockgrpc"
echo -e ""
echo -e
echo -e NO TORRENT
echo -e NO SEEDING
echo -e NO MULTILOGIN
echo -e
# Trigger Reload Services
sleep 1
systemctl restart xray
echo -e "Sucessfully Created"
echo -e "===================="
echo -e ""
read -p "Press enter to continue"
clear
welcome
