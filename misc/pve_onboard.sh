#!/usr/bin/env bash

# Add user
sudo adduser ansible

# Modify group memberships
sudo usermod -aG adm,cdrom,sudo,dip,plugdev,lxd ansible