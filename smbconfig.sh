#!/bin/bash

R='\033[0;31m'
G='\033[0;32m'
E='\033[0m'

first=""
last=""

usage()
{
echo -e "${R} Invalid Arguments ${E}"
echo ""
echo -e "${G} -s : First range of user ${E}"
echo -e "${G} -l: Last range of user ${E}"
}

help()
{
echo -e "${G} Ussage:"
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

for i in $(seq $first $last)
do
echo -e "[PC$i]"
echo -e "path = /data/shared/PC$i"
echo -e "browsable = yes"
echo -e "read only = no"
echo -e "guest ok = yes"
echo -e "valid user = PC$i"
echo ""
done
