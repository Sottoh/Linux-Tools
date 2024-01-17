#!/bin/bash

#Checks if user is root (Will check OS in future)
function check() {
    isroot
    checkos
}

#Check if user is root
function isroot() {
    if [[ $EUID -ne 0 ]]; then
        echo "Please try runnig the script as sudo or root"
        exit 1
    fi

    echo ""

}

function checkos() {
repositories
}

 #Updating repositories
function repositories() {
    echo ""

    echo "Updating repositories."

    if sudo apt-get update &> /dev/null; then
    echo -e "   ➥\e[32mSuccessfully\e[0m updated the repositories!"
    fi

install
}

function install_package() {
    local package_name=$1
    echo "Installing $package_name"
    
    if sudo apt-get install "$package_name" -y &> /dev/null; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed $package_name!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install $package_name!"
    fi
}

function install() {
    echo ""
    echo "Installing tools"
    
    packages=(
        "docker.io"
        "docker-compose"
        "wireshark"
        "nmap"
        "curl"
        "wireguard"
        "openvpn"
        "openjdk-11-jdk"
    )

    for package in "${packages[@]}"; do
        install_package "$package"
    done

    sudo wget https://github.com/angryip/ipscan/releases/download/3.9.1/ipscan_3.9.1_amd64.deb &> /dev/null

    if sudo apt-get install ./ipscan_3.9.1_amd64.deb -y &> /dev/null; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed Angry IP Scanner!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install Angry IP Scanner!"
    fi

    sudo rm -rf ipscan_3.9.1_amd64.deb &> /dev/null
}

check