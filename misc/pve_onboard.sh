#!/usr/bin/env bash

read -p "Do you want to add the 'ansible' user? (y/n): " answer

if [[ $answer == [Yy] ]]; then
    # Add user
    useradd ansible

    # Modify group memberships
    usermod -aG adm,cdrom,sudo,dip,plugdev,lxd ansible

    echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
    echo "User 'ansible' has been added."
else
    echo "No changes were made. User 'ansible' was not added."
fi