#!/bin/bash

set -e

while [[ $# -gt 0 ]]; do
  case $1 in
    -u|--users) USERS=true; shift;;
    -o|--online) ONLINE=true; shift;;
    --help) HELP=true; VERSION=; IP=; MAC=; break;;
    *) shift;;
  esac
done

if [ "$HELP" = true ]; then
    echo "Usage: $(basename "$0") OPTION..."
    echo -e "Print users\n\nOPTIONS"
    echo -e "-u, --users,\t\tList all user accounts\n"\
            "-o, --online\t\tList all online users\n"\
            "    --help\t\tDisplay this help and exit"
fi

if [ "$USERS" = true ]; then
    cut -d: -f1 /etc/passwd | column
fi

if [ "$ONLINE" = true ]; then
    who | awk '{print $1, $2, $3, $4, "(" $5 ")"}' | column -t
fi