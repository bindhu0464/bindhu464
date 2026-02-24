#!/bin/bash

username=$(whoami)
hostname=$(hostname)
datetime=$(date "+%Y-%m-%d %H:%M:%S")
os=$(uname -s)
current_dir=$(pwd)
home_dir=$HOME
users_online=$(who | wc -l)
uptime_info=$(uptime)

echo "╔═══════════════════════════════════════════════════════════════════════════════╗"
echo "║                    SYSTEM INFORMATION DISPLAY                                 ║"
echo "╠═══════════════════════════════════════════════════════════════════════════════╣"
printf "║ Username       : %-27s                                  ║\n" "$username"
printf "║ Hostname       : %-27s                                  ║\n" "$hostname"
printf "║ Date & Time    : %-27s                                  ║\n" "$datetime"
printf "║ OS             : %-27s                                  ║\n" "$os"
printf "║ Current Dir    : %-27s                                 ║\n" "$current_dir"
printf "║ Home Dir       : %-27s                                  ║\n" "$home_dir"
printf "║ Users Online   : %-27s                                  ║\n" "$users_online"
printf "║ Uptime         : %-27s ║\n" "$uptime_info"
echo "╚═══════════════════════════════════════════════════════════════════════════════╝"
