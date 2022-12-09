#!/bin/bash

clear
echo -e ""
echo -e "======================================"
echo -e ""
echo -e ""
echo -e "    [1] Restart All Services"
echo -e "    [2] Restart Xray"
echo -e "    [3] Restart Nginx"
echo -e "    [4] Restart Dropbear"
echo -e "    [5] Restart Stunnel4"
echo -e "    [x] Exit"
echo -e ""
read -p "    Select From Options [1-5 or x] :  " Restart
echo -e ""
echo -e "======================================"
sleep 1
clear
case $Restart in
clear
systemctl restart xray
systemctl restart nginx
systemctl restart dropbear
systemctl restart stunnel4
systemctl restart rc-local
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "          Service/s Restarted         "
echo -e ""
echo -e "======================================"
exit
clear
systemctl restart xray
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "          Service/s Restarted         "
echo -e ""
echo -e "======================================"
exit
clear
systemctl restart nginx
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "          Service/s Restarted         "
echo -e ""
echo -e "======================================"
exit
clear
systemctl restart dropbear
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "          Service/s Restarted         "
echo -e ""
echo -e "======================================"
exit
clear
systemctl restart stunnel4
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "          Service/s Restarted         "
echo -e ""
echo -e "======================================"
exit
exit
echo  "Pilih nomor perintah"
esac
