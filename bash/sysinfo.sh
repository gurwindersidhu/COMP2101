#!/bin/bash

#The system’s fully-qualified domain name (FQDN)
echo "FQDN: $(hostname).home.arpa"

#The operating system name and version, identifying the Linux distro
echo "Host Information:"
   echo "$(hostnamectl)"

# IP addresses the machine has that are not on the 127 network
echo "IP Addresses:"
echo "$(hostname -I)"

#The amount of space available in only the root filesystem
echo "Root Filesystem Status:"
echo "$(df -h /)"
