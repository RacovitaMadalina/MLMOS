#!/bin/bash

# setting the hostname for the virtual machine
# sudo su

# ifup enp0s8
# ifup enp0s3

hostname="localhost.localdomain"

desired_hostname="madalina"
desired_hostname="$desired_hostname.localdomain"
echo $desired_hostname

echo "HOSTNAME=$desired_hostname" > /etc/sysconfig/network
echo "127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4 $1 $desired_hostname" > /etc/hosts
operation_status= hostname $desired_hostname

if $opearation_status; then
	echo "The hostname was set successfully to $1.localdomain"
else
	echo "Failure during hostname setup"
fi

#installed git
yum install git -y

new_dirname="new_dir_repo"
rm -rf ~/$new_dirname
mkdir ~/$new_dirname

cd ~/$new_dirname

#connected to git via ssh
eval `ssh-agent` | ssh-add /etc/ssh/id_rsa_git | git clone git@github.com:RacovitaMadalina/MLMOS.git

#executing the script bootstrap.sh
cd ~/$new_dirname/MLMOS
chmod u-x bootstrap.sh
bash bootstrap.sh
