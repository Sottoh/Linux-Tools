#!/bin/bash

#Checks if user is root (Will check OS in future)
function check() {
    isroot
}

#Check if user is root
function isroot() {
    if [[ $EUID -ne 0 ]]; then
        echo "Please try runnig the script as sudo"
        exit 1
    fi

    echo ""

    repositories
}

 #Updating repositories
function repositories() {
echo ""

echo "Updating repositories."

if sudo apt update &> /dev/null; then
    echo -e "   ➥\e[32mSuccessfully\e[0m updated the repositories!"
fi

install
}

function install() {
echo ""

echo "Installing tools"

if sudo sudo apt install docker.io -y &> /dev/null; then
    echo -e "   ➥\e[32msuccessfully\e[0m installed Docker!"
else
    echo -e "   ➥\e[31mFailed\e[0m to install Docker!"
fi

if sudo sudo apt install docker-compose -y &> /dev/null; then
    echo -e "   ➥\e[32msuccessfully\e[0m installed Docker-Compose!"
else
    echo -e "   ➥\e[31mFailed\e[0m to install Docker-Compose!"
fi

if sudo sudo apt install wireshark -y &> /dev/null; then
    echo -e "   ➥\e[32msuccessfully\e[0m installed Wireshark!"
else
    echo -e "   ➥\e[31mFailed\e[0m to install Wireshark!"
fi

if sudo sudo apt install nmap -y &> /dev/null; then
    echo -e "   ➥\e[32msuccessfully\e[0m installed Nmap!"
else
    echo -e "   ➥\e[31mFailed\e[0m to install Nmap!"
fi

sudo apt install openjdk-11-jdk -y &> /dev/null

sudo wget https://github.com/angryip/ipscan/releases/download/3.9.1/ipscan_3.9.1_amd64.deb &> /dev/null

if sudo apt-get install ~/ipscan_3.9.1_amd64.deb -y &> /dev/null: then
    echo -e "   ➥\e[32msuccessfully\e[0m installed Angry IP Scanner!"
else
    echo -e "   ➥\e[31mFailed\e[0m to install Angry IP Scanner!"
fi

sudo rm -rf ipscan_3.9.1_amd64.deb &> /dev/null

if sudo sudo apt install curl -y &> /dev/null; then
    echo -e "   ➥\e[32msuccessfully\e[0m installed Curl!"
else
    echo -e "   ➥\e[31mFailed\e[0m to install Curl!"
fi

if sudo sudo apt install wireguard -y &> /dev/null; then
    echo -e "   ➥\e[32msuccessfully\e[0m installed Wirewguard!"
else
    echo -e "   ➥\e[31mFailed\e[0m to install Wireguard!"
fi

if sudo sudo apt install openvpn -y &> /dev/null; then
    echo -e "   ➥\e[32msuccessfully\e[0m installed OpenVPN!"
else
    echo -e "   ➥\e[31mFailed\e[0m to install OpenVPN!"
fi
}

check