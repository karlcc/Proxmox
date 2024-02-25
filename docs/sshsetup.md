## ssh setup
Login to control machine with ansible installed, run the following command, then follow the instructions from script:

?> Note that login with ssh promt to enter yes to continue connect with root password.<br>
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

```shell
bash -c "$(wget -qLO - https://raw.githubusercontent.com/karlcc/Proxmox/main/misc/sshsetup.sh)"
```
## add ansible user
run the following command on ansible control machine:
```shell
bash -c "$(wget -qLO - https://raw.githubusercontent.com/karlcc/Proxmox/main/misc/pve_onboard.sh)"
```