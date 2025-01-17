#!/bin/bash
 
R='\033[0;31m'
G='\033[0;32m'
O='\033[0;33m'
E='\033[0m'
 
first=""
last=""

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" >&2
	exit 1
fi
 
usage() {
    echo -e "${R}Invalid Arguments${E}"
    echo ""
    echo -e "${G}-s : First range of user${E}"
    echo -e "${G}-l : Last range of user${E}"
    echo -e "${G}-p : Enter the password to be set${E}"
}
 
help() {
    echo -e "${G}Usage:${E}"
    echo -e "${G}Example: $0 -s 1 -l 10${E}"
    echo ""
    echo -e "${G}-s : First range of user${E}"
    echo -e "${G}-l : Last range of user${E}"
    echo -e "${G}-p : Enter the password to be set${E}"
}
 
while getopts ":s:l:p:h" opt; do
    case ${opt} in
        s) first=$OPTARG ;;  
        l) last=$OPTARG ;;  
        p) password=$OPTARG ;;  
        h) help; exit 0 ;;  
        \?) usage; exit 1 ;;
    esac
done
 
if [[ -z "$first" || -z "$last" || -z "$password" ]]; then
    usage
    exit 1
fi
 
output_file="$first-$last-user.txt"

for i in $(seq $first $last); do
    echo -e "[PC$i]" >> "$output_file"
    echo -e "path = /data/shared/PC$i" >> "$output_file"
    echo -e "browsable = yes" >> "$output_file"
    echo -e "read only = no" >> "$output_file"
    echo -e "guest ok = yes" >> "$output_file"
    echo -e "valid user = PC$i" >> "$output_file"
    echo "" >> "$output_file"

    sudo useradd -M -s /sbin/nologin "PC$i"
    echo -e "${G}User PC$i created.${E}"

    (echo "$password";echo "$password") | sudo smbpasswd -a "PC$i"
    echo -e "${G}Password for PC$i set to '${password}'${E}"
    
    sudo mkdir -p "/data/shared/PC$i/Desktop"
    sudo mkdir -p "/data/shared/PC$i/Downloads"
    sudo mkdir -p "/data/shared/PC$i/Documents"
    sudo mkdir -p "/data/shared/PC$i/Pictures"
    sudo mkdir -p "/data/shared/PC$i/Music"
    sudo mkdir -p "/data/shared/PC$i/Videos"
    sudo chown "PC$i:PC$i" "/data/shared/PC$i"
    sudo chmod 700 "/data/shared/PC$i"
    echo -e "${G}Directory /data/shared/PC$i configured.${E}"
done 
 
if [[ -e "$output_file" ]]; then
    echo -e "${G}File Created:${E} ${O}$output_file${E}"
fi
 
read -p "Do you want to append the created file to /etc/samba/smb.conf? (y/n): " confirm
 
if [[ $confirm =~ ^[yY]$ ]]; then
    sudo cat "$output_file" >> /etc/samba/smb.conf
    if [[ $? -eq 0 ]]; then
        echo -e "${G}Configuration successfully appended to /etc/samba/smb.conf.${E}"
        echo -e "${G}Restart Samba service to apply changes.${E}"
        
        read -p "Do you want to restart the Samba service now? (y/n): " confirm2
        if [[ $confirm2 =~ ^[yY]$ ]]; then
            sudo systemctl restart smbd
            if [[ $? -eq 0 ]]; then
                echo -e "${G}Samba service successfully restarted.${E}"
            else
                echo -e "${R}Failed to restart Samba service. Try manually using:${E} ${O}sudo systemctl restart smbd${E}"
            fi
        else
            echo -e "${R}Samba service restart skipped.${E}"
        fi
    else
        echo -e "${R}Failed to append configuration to /etc/samba/smb.conf.${E}"
    fi
elif [[ $confirm =~ ^[nN]$ ]]; then
    echo -e "${R}Configuration not appended.${E}"
else
    echo -e "${R}Invalid input. Please enter 'y' or 'n'${E}"
fi
