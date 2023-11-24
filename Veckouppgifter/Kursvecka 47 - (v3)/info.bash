#!/bin/bash

set -e

while [[ $# -gt 0 ]]; do
  case $1 in
    -v|--version) VERSION=true; shift;;
    -i|--ip) IP=true; shift;;
    -m|--mac) MAC=true; shift;;
    -a|--all) VERSION=true; IP=true; MAC=true; shift;;
    --help) HELP=true; VERSION=; IP=; MAC=; break;;
    *) shift;;
  esac
done

if [ "$HELP" = true ]; then
    echo "Usage: $(basename "$0") OPTION..."
    echo -e "Print out system information\n\nOPTIONS"
    echo -e "-a, --all,\t\tdisplay all information\n"\
            "-v, --version\t\tdisplay linux version\n"\
            "-i, --ip\t\tdisplay IP address\n"\
            "    --help\t\tdisplay this help and exit"
fi

if [ "$VERSION" = true ]; then
    echo "Linux version: $(lsb_release -d | sed "s/Description:\t//")"
fi

if [ "$IP" = true ]; then
    interface=$(ip route get 8.8.8.8 | head -1 | cut -d " " -f5)
    echo "IP address: $(ip addr show $interface | grep -oP "inet \K[^ ]+")"
fi

if [ "$MAC" = true ]; then
    interface=$(ip route get 8.8.8.8 | head -1 | cut -d " " -f5)
    echo "MAC address(ether): $(ip addr show $interface | grep -oP "link/ether \K[^ ]+")"
fi
