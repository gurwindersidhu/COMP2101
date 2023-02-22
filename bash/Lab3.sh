#!/bin/bash
# Remainder! before running this script make sure to login as root so that commands can run properly as /etc/hosts file needs root permission to add ip address(other commands also)
# Install Curl before running this script if it is not installed in your terminal

# Step 1 
which lxd >/dev/null
if [ $? -ne 0 ]; then
   sudo snap install lxd
else 
   echo "Cannot install lxd again beacuse it is alraedy downloaded!"
fi

# step 2
ip a s lxdbr0 | grep lxdbr0 >/dev/null
if [ $? -eq 0 ]; then
   echo "lxdbr0 interface is present"
else
   sudo lxd init --auto
   echo "Device "lxdbr0" exists now"
fi

# step 3
lxc list | grep -w COMP2101-S22 >/dev/null
if [ $? -eq 0 ]; then
   echo "COMP2101-S22 is already present, Create a new one"
else
   sudo lxc launch ubuntu:22.04 COMP2101-S22
fi

#step 4
IP=$(lxc list | grep -w COMP2101-S22 | awk '{print $6}')
if [ $? -eq 0 ];then
echo "$IP COMP2101-S22" >> /etc/hosts
fi


#step 5
lxc exec COMP2101-S22 -- apt-get install apache2 >/dev/null
if [ $? -ne 0 ]; then
   echo "Apache2 is active and running already"
else
   sudo lxc exec COMP2101-S22 -- apt-get install apache2 | echo "apache2 service is running now"
fi 

#step 6
curl http://COMP2101-S22 >/dev/null 
if [ $? -ne 0 ]; then
   echo " The connection was unsuccessful, Try again!"
   else
   echo "**Successful** Connected!"
fi
