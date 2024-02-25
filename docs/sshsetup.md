## ssh setup
Login to control machine with ansible installed, run the following command:
```shell
bash -c "$(wget -qLO - https://raw.githubusercontent.com/karlcc/Proxmox/main/misc/sshsetup.sh)"
```
## add ansible user
run the following command on ansible control machine:
```shell
bash -c "$(wget -qLO - https://raw.githubusercontent.com/karlcc/Proxmox/6e8bfded924297bb93d31d849d74bd1c01f48795/misc/pve_onboard.sh)"
```