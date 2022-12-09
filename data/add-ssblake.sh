#!/bin/bash

clear
domain=$(cat /etc/adi/domain)
porttls="443"
portnontls="80"
fix=%26
# Method Shadowsocks
method1="aes-128-gcm"
method2="aes-256-gcm"
method3="chacha20-ietf-poly1305"
method10="2022-blake3-aes-128-gcm"
method11="2022-blake3-aes-256-gcm"
method12="2022-blake3-chacha20-poly1305"
# Read User Info
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
	read -rp "User: " -e user
	CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/netz/ssblakews.json | wc -l)
	if [[ ${CLIENT_EXISTS} == '2' ]]; then
			echo ""
			echo "User ini telah ada, Tolong gunakan nama lain."
			exit 1
	fi
done
uuid=$(xray uuid)
genid=$(openssl rand -base64 16)
serverid="CXX4y7hOW6XlLygCsx0U1w=="
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
# Buat Akun
# WS TLS
sed -i '/#memberblakews$/a\### '"$user $exp"'\
},{"password": ''"'"$genid"'"'', "email": ''"'"$user"'"''' /usr/local/etc/xray/netz/ssblakews.json
# WS NON TLS
sed -i '/#memberblakewsnon$/a\### '"$user $exp"'\
},{"password": ''"'"$genid"'"'', "email": ''"'"$user"'"''' /usr/local/etc/xray/netz/ssblakewsnon.json
# WS NON TLS
sed -i '/#memberblakekuotahabis$/a\### '"$user $exp"'\
},{"password": ''"'"$genid"'"'', "email": ''"'"$user"'"''' /usr/local/etc/xray/netz/ssblakekuota.json
# GRPC
sed -i '/#memberblakegrpc$/a\### '"$user $exp"'\
},{"password": ''"'"$genid"'"'', "email": ''"'"$user"'"''' /usr/local/etc/xray/netz/ssblakegrpc.json
# Encrypt Technical
encrypt10=$(echo -n "${method10}:${serverid}:${genid}" | base64 -w0)
# Converted
ssblakews="ss://${encrypt10}@${domain}:${porttls}?path=%2Fnetzblake&security=tls&type=ws#${user}"
ssblakewsnon="ss://${encrypt10}@${domain}:${portnontls}?path=%2Fnetzblake&security=none&type=ws#${user}"
ssblakekuota="ss://${encrypt10}@${domain}:${portnontls}?path=%2Fkuota-habis%2Fnetzblake&security=none&type=ws#${user}"
ssblakegrpc="ss://${encrypt10}@${domain}:${porttls}?mode=gun&security=tls&type=grpc&serviceName=netzblakegrpc#${user}"
# Converted Telegram
ssblakewstelegram="ss://${encrypt3}@${domain}:${porttls}?path=/netzblake${fix}security=tls${fix}type=ws#${user}"
ssblakewsnontelegram="ss://${encrypt3}@${domain}:${portnontls}?path=/netzblake${fix}security=none${fix}type=ws#${user}"
ssblakekuotatelegram="ss://${encrypt3}@${domain}:${portnontls}?path=/kuota-habis/netzblake${fix}security=none${fix}type=ws#${user}"
ssblakegrpctelegram="ss://${encrypt3}@${domain}:${porttls}?mode=gun${fix}security=tls${fix}type=grpc${fix}serviceName=netzblakegrpc#${user}"
# Cleanup
clear
# Post Telegram
if [[ -z $BOT_TOKEN ]]; then
	echo "Terimakasih Telah Menggunakan Layanan NetzXRay Bot"
elif [[ -z $CHAT_ID ]]; then
	echo -e " "
else
tg_send_message --chat_id "$CHAT_ID" --text "*SHADOWSOCKS 2022 BERHASIL DIBUAT !*
*ISP*   : $ISP
*IP*    : $IPADRESS
*Domain*        : $domain
*Client*        : $user
*Password*      : $uuid
*Aktif Sampai* : $exp
SHADOWSOCKS2022
Shadowsocks WS          : \`$ssblakewstelegram\`
Shadowsocks WS NON      : \`$ssblakewsnontelegram\`
Shadowsocks ORBIT       : \`$ssblakekuotatelegram\`
Shadowsocks GRPC        : \`$ssblakegrpctelegram\`
AutoScript By Adi Subagja" --parse_mode "Markdown" >/dev/null
echo "Terimakasih Telah Menggunakan Layanan NetzXRay"
fi
# Informasi Akun
echo -e
XRAY/SHADOWSOCKS2022
echo -e Remarks     : "$user"
echo -e PASS        : "$uuid"
echo -e Domain      : "$domain"
echo -e Port        : "$porttls & $portnontls"
echo -e Masa Aktif  : "$exp"
echo -e Path        : "/netzblake"
echo -e Path Orbit      : "/kuota-habis/netzblake"
echo -e ServiceName : "netzblakegrpc"
echo -e Encrypt     : "$method10"
echo -e
echo -e WS TLS      : "$ssblakews"
echo -e ""
echo -e
echo -e WS NON      : "$ssblakewsnon"
echo -e ""
echo -e
echo -e ORBIT       : "$ssblakekuota"
echo -e ""
echo -e
echo -e GRPC        : "$ssblakegrpc"
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
