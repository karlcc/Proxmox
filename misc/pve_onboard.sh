#!/usr/bin/env bash

read -p "Enter the IP address of the remote IP of PVE node: " remote_ip
ssh -i ~/.ssh/ansible-key root@$remote_ip

read -p "Do you want to add the 'ansible' user? (y/n): " answer

if [[ $answer == [Yy] ]]; then
    # Add user with home directory
    useradd -m ansible

    # Modify group memberships
    usermod -aG adm,cdrom,sudo,dip,plugdev,lxd ansible

    echo "ansible ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/ansible >/dev/null
    echo "User 'ansible' has been added."
else
    echo "No changes were made. User 'ansible' was not added."
fi


