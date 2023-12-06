#!/bin/bash

which_result=$(command -v $1)

if [ -z $which_result ]; then
    echo "Installning $1"
    #yay -Syu $1
    sudo apt-get update
    sudo apt-get install $1
fi
echo "$1 installed "
echo "Running $2 processes of $1 for $3 seconds in xterm"

for i in $(seq 1 $2)
do
    2>/dev/null 1>&2 xterm -e "$1" &
done
sleep $3

pgrep -P $$ | xargs kill

echo -n "Uninstall $1 ? (y/n): "
read val
if [[ "$val" == "y" ]]; then
    echo "Uninstallning $1"
    #yay -R $1
    sudo apt-get uninstall $1
fi
