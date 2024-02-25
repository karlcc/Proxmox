#!/usr/bin/env bash

current_user=$(whoami)

read -p "Press enter to generate an SSH key pair for the '$current_user' user..."

# Run ssh-keygen to generate Ed25519 SSH key pair for the current user
ssh-keygen -t ed25519 -f ~/.ssh/ansible-key -N "" -q

echo "SSH key pair has been generated for the '$current_user' user."

read -p "Enter the IP address of the remote PC: " remote_ip

# Transfer the public key to the remote PC
ssh-copy-id -i ~/.ssh/ansible-key.pub root@$remote_ip