#!/usr/bin/env bash

read -p "Do you want to add the 'ansible' user? (y/n): " answer

if [[ $answer == [Yy] ]]; then
    # Add user with home directory
    sudo useradd -m ansible

    # Modify group memberships
    sudo usermod -aG adm,cdrom,sudo,dip,plugdev,lxd ansible

    echo "ansible ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/ansible >/dev/null
    echo "User 'ansible' has been added."
else
    echo "No changes were made. User 'ansible' was not added."
fi

read -p "Press enter to generate an SSH key pair for the 'ansible' user..."

# Run ssh-keygen to generate Ed25519 SSH key pair as ansible user
sudo -i -u ansible ssh-keygen -t ed25519 -f /home/ansible/.ssh/ansible-key -N "" -q

echo "SSH key pair has been generated for the 'ansible' user."

read -p "Enter the IP address of the remote PC: " remote_ip

# Transfer the public key to the remote PC
ssh-copy-id -i /home/ansible/.ssh/ansible-key.pub root@$remote_ip