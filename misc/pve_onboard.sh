#!/usr/bin/env bash

# Add user
useradd ansible

# Modify group memberships
usermod -aG adm,cdrom,sudo,dip,plugdev,lxd ansible

echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible