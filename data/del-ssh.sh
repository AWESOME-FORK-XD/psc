#!/bin/bash

clear
domain=$(cat /etc/adi/domain)
porttls="443"
portnontls="80"
fix=%26
# Delete SSH USER !
read -p "Masukan Username Yang Ingin Dihapus : " Pengguna
if getent passwd $Pengguna > /dev/null 2>&1; then
	userdel $Pengguna
	echo -e "$Pengguna Telah Dihapus !"
else
	echo -e "Gagal: $Pengguna Tidak Ada."
fi
