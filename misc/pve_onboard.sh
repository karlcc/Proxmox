#!/usr/bin/env bash

read -p "Enter the IP address of the remote PVE node: " remote_ip
read -p "Do you want to add the 'ansible' user? (y/n): " answer

if [[ $answer == [Yy] ]]; then
    # Connect to the remote PC using the SSH key
    ssh -i ~/.ssh/ansible-key root@$remote_ip << EOF

        # Add user with home directory
        useradd -m ansible

        # Modify group memberships
        usermod -aG adm,cdrom,sudo,dip,plugdev,lxd ansible

        echo "ansible ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/ansible >/dev/null
        echo "User 'ansible' has been added."

EOF

else
    echo "No changes were made. User 'ansible' was not added."
fi

echo "SSH connection closed."