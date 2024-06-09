ansible all --list-hosts
sudo mkdir /etc/ansible
sudo mv /etc/ansible/hosts /etc/ansible/hosts.20240116
sudo nano /etc/ansible/hosts
echo "[proxmox_labs]" | sudo tee -a /etc/ansible/hosts && echo "10.10.2.1" | sudo tee -a /etc/ansible/hosts

# or
echo "[proxmox_labs]" | tee -a ~/inventory && echo "10.10.2.1" | tee -a ~/inventory

[proxmox_lab]
10.10.2.1

sudo mv /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.20240116
echo -n | sudo tee /etc/ansible/ansible.cfg
echo "[defaults]" | tee -a ~/ansible.cfg && echo "host_key_checking=False" | tee -a ~/ansible.cfg
# or
echo "[defaults]" | sudo tee -a /etc/ansible/ansible.cfg && echo "host_key_checking=False" | sudo tee -a /etc/ansible/ansible.cfg

[defaults]
host_key_checking=False
interpreter_python=auto_silent

# ansible-config init --disabled > /etc/ansible/ansible.cfg

# ansible-config init --disabled | sudo tee /etc/ansible/ansible.cfg > /dev/null

# ansible all -m ping -u root

# ansible all -m ping -u root -k

# ansible-playbook test_localhost.yml

# test connection using root user with remote node password
ansible proxmox_labs -i ./inventory -m ping -u root -k
# ansible pbs -i ./inventory -m ping -u root -k

ansible-playbook pve_onboard.yml -i inventory -u root -k -l proxmox_labs
# ansible-playbook pve_onboard.yml -i inventory -u root -k -l pbs
# ansible-playbook pve_onboard.yml -i inventory -u root -k

ansible proxmox_labs -m ping -i ./inventory -u ansible --private-key ~/.ssh/ansible-key

ansible-playbook pve_update.yml -i ./inventory -u ansible --private-key ~/.ssh/ansible-key -l proxmox_labs

When using Ansible for the first time to ping a host, you might need to specify the password for the user. You can use the -k option to prompt for the password interactively. Here's an example:

sh
Copy code
ansible all -m ping -u root -k
After running this command, Ansible will prompt you for the password for the specified user (root in this case).

Alternatively, you can use the -K option to prompt for the sudo password if your user requires elevated privileges:

sh
Copy code
ansible all -m ping -u root -K
Again, this will prompt you for the sudo password interactively. Choose the option that fits your authentication setup.

nano ~/proxmox_update.yml

ansible-playbook -u root ~/proxmox_update.yml

PBS
ansible pbs -i ./inventory -m ping -u root -k

ansible-playbook pbs_onboard.yml -i inventory -u root -k -l pbs

ansible pbs -m ping -i ./inventory -u ansible --private-key ~/.ssh/ansible-key

ansible-playbook pve_update.yml -i ./inventory -u ansible --private-key ~/.ssh/ansible-key -l pbs

ansible-playbook pve_postfix.yml -i ./inventory -u ansible --private-key ~/.ssh/ansible-key -l pbs

echo "Test message" | mail -s subject karl.logon@gmail.com

pbs console:
proxmox-backup-manager user update root@pam --email me@karldigi.dev

ansible-playbook pbs_useremail.yml -i ./inventory -u ansible --private-key ~/.ssh/ansible-key -l pbs