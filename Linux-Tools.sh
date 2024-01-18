#!/bin/bash

#Checks if user is root and if user has apt-get or yay package manager
function check() {
    isroot
    checkpm
}

#Checks if user is root
function isroot() {
    if [[ $EUID -ne 0 ]]; then
        echo "Please try runnig the script as sudo"
        exit 1
    fi
}

function command_exists() {
    command -v "$1" >/dev/null 2>&1
}

#Checks if APT or Yay is available
function checkpm() {
    if command_exists apt-get; then
    #echo "Detected APT package manager. Installing programs!"

    apt_repositories

    elif command_exists yay; then
    echo "Detected Yay package manager. Installing programs!"

    yay_package

    # elif command_exists rpm; then
    # echo "Detected RPM package manager. Installing programs..."

    # rpm_install

    else
    echo "No supported package manager found. This script currently supports APT on Debian-based systems and Yay on Arch-based systems."
    exit 1
    fi

}

#Updates repositories for APT package manager
function apt_repositories() {
    echo ""

    echo "Updating repositories."

    if sudo apt-get update &> /dev/null; then
    echo -e "   ➥\e[32mSuccessfully\e[0m updated the repositories!"
    fi

apt_install
}

#Downloads the packages with APT
function apt_package() {
    echo ""

    local package_name=$1
    echo "Installing $package_name"
    
    if sudo apt-get install "$package_name" -y &> /dev/null; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed $package_name!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install $package_name!"
    fi
}

function apt_install() {
    echo ""
    
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
        apt_package "$package"
    done

    #Angry IP Scanner is retarded, or I am
    sudo wget https://github.com/angryip/ipscan/releases/download/3.9.1/ipscan_3.9.1_amd64.deb &> /dev/null

    if sudo apt-get install ./ipscan_3.9.1_amd64.deb -y &> /dev/null; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed Angry IP Scanner!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install Angry IP Scanner!"
    fi

    sudo rm -rf ipscan_3.9.1_amd64.deb &> /dev/null
}

#Downloads the packages with Yay
function yay_package() {
    echo""

    local package_name=$1
    echo "Installing $package_name"
    
    if yay -Syu --noconfirm "$package_name" &> /dev/null; then
        echo -e "   ➥\e[32msuccessfully\e[0m installed $package_name!"
    else
        echo -e "   ➥\e[31mFailed\e[0m to install $package_name!"
    fi
}

function yay_install() {
    echo ""
    echo "Installing tools"
    
    packages=(
        "aur/docker-git"
        "aur/docker-compose-git"
        "aur/wireshark-git"
        "extra/namp"
        "aur/jdk11"
        "aur/ipscan"
        "aur/curl-git"
        "aur/wireguard"
        "aur/openvpn3"
    )

    for package in "${packages[@]}"; do
        yay_package "$package"
    done
}

check