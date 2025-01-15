#!/bin/bash
 
R='\033[0;31m'
G='\033[0;32m'
O='\033[0;33m'
E='\033[0m'
 
first=""
last=""
 
usage() {
    echo -e "${R} Invalid Arguments ${E}"
    echo ""
    echo -e "${G} -s : First range of user ${E}"
    echo -e "${G} -l: Last range of user ${E}"
}
 
help() {
    echo -e "${G} Usage:"
    echo -e "${G} Example: $0 -s 1 -l 10 ${E}"
    echo ""
    echo -e "${G} -s : First range of user ${E}"
    echo -e "${G} -l: Last range of user ${E}"
}
 
while getopts ":s:l:h" opt; do
    case ${opt} in
        s) first=$OPTARG ;;  
        l) last=$OPTARG ;;   
        h) help; exit 0 ;;   
        \?) usage; exit 1 ;;
    esac
done
 
if [[ -z "$first" || -z "$last" ]]; then
    usage
    exit 1
fi
 
for i in $(seq $first $last); do
    echo -e "[PC$i]"
    echo -e "path = /data/shared/PC$i"
    echo -e "browsable = yes"
    echo -e "read only = no"
    echo -e "guest ok = yes"
    echo -e "valid user = PC$i"
    echo ""
done > $first-$last-user.txt   
 
if [ -e $first-$last-user.txt ]; then
    echo -e "${G}File Created:${E} ${O}$first-$last-user.txt${E}"
fi
 
read -p "Do you want to append the created file to the /etc/smb/smb.conf? (y/n):" confirm
 
if [[ $confirm =~ ^[yY]$ ]]; then
    sudo cat $first-$last-user.txt >> /etc/samba/smb.conf
	if [[ $? -eq 0 ]]; then
        echo -e "${G}Configuration Successfully appended to /etc/samba/smb.conf${E}"
        echo -e "${G}Restart samba service to apply changes${E}"
        read -p "Do you want to restart the samba service now? (y/n):" confirm2
		if [[ $confirm2 =~ ^[yY]$ ]]; then
		sudo systemctl restart smbd  
			if [[ $? -eq 0 ]]; then    
                echo -e "${G}Successfully restarted the smb server${E}"   
                echo -e "${R}Encountered some error. Try manually restarting smb using command:${E} ${O}sudo systemctl restart smbd${E}"
			fi 
		fi
	fi
        elif [[ $confirm =~ ^[nN]$ ]];then
        echo -e "${O}Skipped${E}"
        else
        echo -e "${R}Invalid input enter ${O}'y'${E} or ${O}'n'${E} ${E}"
fi

