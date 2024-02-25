#!/usr/bin/env bash

read -p "Enter the IP address of the remote PVE node: " remote_ip
read -p "Do you want to add the 'ansible' user? (y/n): " answer

if [[ $answer == [Yy] ]]; then
    # Connect to the remote PC using the SSH key
    ssh -i ~/.ssh/ansible-key root@$remote_ip << EOF

        # Update package lists
        apt update

        # Install sudo package
        apt install -y sudo

        # Add user with home directory
        useradd -m ansible

        # Modify group memberships
        usermod -aG adm,cdrom,sudo,dip,plugdev,lxd ansible

        echo "ansible ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/ansible >/dev/null
        echo "User 'ansible' has been added."

        # Create the ~/.ssh directory for the new ansible user
        mkdir -p /home/ansible/.ssh
        chown ansible:ansible /home/ansible/.ssh
        chmod 700 /home/ansible/.ssh

        # Copy SSH public key to the new ansible user's directory
        cp ~/.ssh/ansible-key.pub /home/ansible/.ssh/authorized_keys
        chown ansible:ansible /home/ansible/.ssh/authorized_keys
        chmod 600 /home/ansible/.ssh/authorized_keys

EOF

else
    echo "No changes were made. User 'ansible' was not added."
fi

echo "SSH connection closed."