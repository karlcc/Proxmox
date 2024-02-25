## ssh setup
Login to control machine with ansible installed, run the following command:
```shell
bash -c "$(wget -qLO - https://raw.githubusercontent.com/karlcc/Proxmox/main/misc/sshsetup.sh)"
```
## add ansible user
run the following command on ansible control machine:
```shell
bash -c "$(wget -qLO - https://raw.githubusercontent.com/karlcc/Proxmox/e197d5193e0a9c3790fe74c57b0a3e388f223f64/misc/pve_onboard.sh)"
```