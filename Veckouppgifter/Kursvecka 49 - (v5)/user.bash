#!/bin/bash

set -e

while [[ $# -gt 0 ]]; do
  case $1 in
    -u|--users) USERS=true; shift;;
    -o|--online) ONLINE=true; shift;;
    --help) HELP=true; USERS=; ONLINE=; break;;
    *) shift;;
  esac
done

if [ "$HELP" = true ]; then
    echo "Usage: $(basename "$0") OPTION..."
    echo -e "Print users\n\nOPTIONS"
    echo -e "\t-u, --users,\t\tList all user accounts\n"\
            "\t-o, --online\t\tList all online users\n"\
            "\t    --help\t\tDisplay this help and exit"
fi

if [ "$USERS" = true ]; then
    cut -d: -f1 /etc/passwd | column -t
fi

if [ "$ONLINE" = true ]; then
    who | column -t
fi
