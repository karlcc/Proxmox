ansible-galaxy install arillso.postfix

ansible-playbook pve_postfix.yml -i ./inventory -u ansible --private-key ~/.ssh/ansible-key -l proxmox_labs