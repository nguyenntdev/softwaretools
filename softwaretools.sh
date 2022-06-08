#!/bin/bash

title="Software Tools - nguyennt.dev"
echo -e '\033]2;'$mytitle'\007'
username=$(whoami)
ver="0.1.0"
if [ -n "$(command -v lsb_release)" ]; then
    distro=$(lsb_release -s -d)
elif [ -f "/etc/os-release" ]; then
    distro=$(grep PRETTY_NAME /etc/os-release | sed 's/PRETTY_NAME=//g' | tr -d '="')
fi
pacman -S --needed git base-devel --noconfirm
clear

echo "==================================================="
echo "|    Software Tool - Dang chay tren $distro"
echo "|-------------------------------------------------"
echo "|    Xin vui long chon loai phan mem phia ben duoi"
echo "==================================================="
PS3='Lua chon cua ban: '
options=("Trinh quan ly goi" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"; do
    case $opt in
    "Trinh quan ly goi")
        echo "Xin vui long chon phan mem can cai dat"
        PS3='Lua chon cua ban: '
        options=("yay" "pamac" "dpkg" "aurutils" "Thoat")
        select opt in "${options[@]}"; do
            case $opt in
            "yay")
                echo "Xin cho..."
                cd /temp/
                git clone https://aur.archlinux.org/yay-bin.git
                cd yay-bin
                makepkg -si
                ;;
            "pamac")
                echo "Xin cho..."
                pacman -S mason-git --noconfirm
                cd /temp/
                mkdir builddir && cd builddir
                meson setup --prefix=/usr --sysconfdir=/etc --buildtype=release
                meson compile
                sudo meson install
                ;;
            "dpkg")
                echo "Xin cho..."
                pacman -S dpkg --noconfirm
                ;;
            "Thoat")
                break
                ;;
            *) echo "Lua chon khong hop le: $REPLY" ;;
            esac
        done

        ;;
    "Option 2")
        echo "you chose choice 2"
        ;;
    "Option 3")
        echo "you chose choice $REPLY which is $opt"
        ;;
    "Quit")
        break
        ;;
    *) echo "invalid option $REPLY" ;;
    esac
done
