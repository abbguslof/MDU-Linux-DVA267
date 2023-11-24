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
    echo "Linux version: $(uname -r)"
fi

if [ "$IP" = true ]; then
    interface=$(ip route get 8.8.8.8 | awk -v N=5 '{print $N}')
    arr=($(ip addr show $interface | grep "inet "))
    echo "IP address: ${arr[1]}"
fi

if [ "$MAC" = true ]; then
    interface=$(ip route get 8.8.8.8 | awk -v N=5 '{print $N}')
    arr=($(ip addr show $interface | grep "link/ether"))
    echo "Mac address(ether): ${arr[1]}"
fi
