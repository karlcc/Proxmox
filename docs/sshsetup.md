## ssh setup
Login to control machine with ansible installed, run the following command:
```shell
bash -c "$(wget -qLO - https://raw.githubusercontent.com/karlcc/Proxmox/main/misc/sshsetup.sh)"
```
## add ansible user
run the following command on ansible control machine:
```shell
bash -c "$(wget -qLO - https://raw.githubusercontent.com/karlcc/Proxmox/52c55364bb1105fba4a26d3dc8cda32f66d2b6e9/misc/pve_onboard.sh)"
```