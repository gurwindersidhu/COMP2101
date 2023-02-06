#!/bin/bash

#The purpose of this script is to display some important identity information about a computer 

cat<<EOF

Report for $(hostname)
======================
FQDN : $(hostname).home.arpa
Operating System name and Version: $(lsb_release -d | awk '{print $2, $3, $4}')
IP Address : $(hostname -I)
Root Filesystem Freespace: $(df -h /dev/sda3 | grep -v Avail | awk '{print $4}') 
=======================
 
EOF

