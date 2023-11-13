#!/bin/bash

set -e

cd "/home/$(whoami)"
mkdir Logs -p
sudo find /var/log -name "*.log" | sudo xargs cp --no-preserve=mode -t Logs/
tar cvf Logs/log.tar Logs/*.log 
rm -f Logs/*.log
ls -lah Logs/
