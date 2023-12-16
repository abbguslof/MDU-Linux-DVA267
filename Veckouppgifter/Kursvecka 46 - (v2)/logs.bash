#!/bin/bash

set -e

cd
mkdir Logs -p
sudo find /var/log -name "*.log" | sudo xargs cp --no-preserve=mode -t Logs/
sudo tar czf Logs/log.tar.gz Logs/*.log 
rm -f Logs/*.log
ls Logs/
