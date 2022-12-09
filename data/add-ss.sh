#!/bin/bash

# ENV
domain=$(cat /etc/adi/domain)
porttls="443"
portnontls="80"
fix=%26
# Method Shadowsocks
method1="aes-128-gcm"
method2="aes-256-gcm"
method3="chacha20-ietf-poly1305"
# Read User Info
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
	read -rp "User: " -e user
	CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/netz/ssws.json | wc -l)
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
sed -i '/#membershadowsocksws$/a\### '"$user $exp"'\
},{"password": ''"'"$uuid"'"'',"method": ''"'"$method3"'"'', "email": ''"'"$user"'"''' /usr/local/etc/xray/netz/ssws.json
# WS NON TLS
sed -i '/#membershadowsockswsnon$/a\### '"$user $exp"'\
},{"password": ''"'"$uuid"'"'',"method": ''"'"$method3"'"'', "email": ''"'"$user"'"''' /usr/local/etc/xray/netz/sswsnon.json
# WS NON TLS ORBIT
sed -i '/#membershadowsockskuotahabis$/a\### '"$user $exp"'\
},{"password": ''"'"$uuid"'"'',"method": ''"'"$method3"'"'', "email": ''"'"$user"'"''' /usr/local/etc/xray/netz/sskuota.json
# GRPC
sed -i '/#membershadowsocksgrpc$/a\### '"$user $exp"'\
},{"password": ''"'"$uuid"'"'',"method": ''"'"$method3"'"'', "email": ''"'"$user"'"''' /usr/local/etc/xray/netz/ssgrpc.json
# Encrypt Technical
encrypt3=$(echo -n "${method3}:${uuid}" | base64 -w0)
# Converted
ssws="ss://${encrypt3}@${domain}:${porttls}?path=%2Fnetzss&security=tls&type=ws#${user}"
sswsnon="ss://${encrypt3}@${domain}:${portnontls}?path=%2Fnetzss&security=none&type=ws#${user}"
sskuota="ss://${encrypt3}@${domain}:${portnontls}?path=%2Fkuota-habis%2Fnetzss&security=none&type=ws#${user}"
ssgrpc="ss://${encrypt3}@${domain}:${porttls}?mode=gun&security=tls&type=grpc&serviceName=netzssgrpc#${user}"
# Converted Telegram
sswstelegram="ss://${encrypt3}@${domain}:${porttls}?path=/netzss${fix}security=tls${fix}type=ws#${user}"
sswsnontelegram="ss://${encrypt3}@${domain}:${portnontls}?path=/netzss${fix}security=none${fix}type=ws#${user}"
sskuotatelegram="ss://${encrypt3}@${domain}:${portnontls}?path=/netzss${fix}security=none${fix}type=ws#${user}"
ssgrpctelegram="ss://${encrypt3}@${domain}:${porttls}?mode=gun${fix}security=tls${fix}type=grpc${fix}serviceName=netzssgrpc#${user}"
# Cleanup
clear
# Post Telegram
if [[ -z $BOT_TOKEN ]]; then
	echo "Terimakasih Telah Menggunakan Layanan NetzXRay Bot"
elif [[ -z $CHAT_ID ]]; then
	echo -e " "
else
tg_send_message --chat_id "$CHAT_ID" --text "*SHADOWSOCKS BERHASIL DIBUAT !*
*ISP*   : $ISP
*IP*    : $IPADRESS
*Domain*        : $domain
*Client*        : $user
*Password*      : $uuid
*Aktif Sampai* : $exp
SHADOWSOCKS
Shadowsocks WS          : \`$sswstelegram\`
Shadowsocks WS NON      : \`$sswsnontelegram\`
Shadowsocks ORBIT       : \`$sskuotatelegram\`
Shadowsocks GRPC        : \`$ssgrpctelegram\`
AutoScript By @simbah69" --parse_mode "Markdown" >/dev/null
echo "Terimakasih Telah Menggunakan Layanan NetzXRay"
fi
# Informasi Akun
echo -e
XRAY/SHADOWSOCKS
echo -e Remarks     : "$user"
echo -e PASS        : "$uuid"
echo -e Domain      : "$domain"
echo -e Port        : "$porttls & $portnontls"
echo -e Masa Aktif  : "$exp"
echo -e Path        : "/netzss"
echo -e Path Orbit      : "/kuota-habis/netzss"
echo -e ServiceName : "netzssgrpc"
echo -e Encrypt     : "$method3"
echo -e
echo -e WS TLS      : "$ssws"
echo -e ""
echo -e
echo -e WS NON      : "$sswsnon"
echo -e ""
echo -e
echo -e ORBIT       : "$sskuota"
echo -e ""
echo -e
echo -e GRPC        : "$ssgrpc"
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
