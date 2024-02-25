# Preparation

Before you start with Ansible, you'll need the following:

1. `Control Machine`: Ansible is agentless, which means you don't need to install any software on the managed hosts. Instead, you need a control machine from which you'll run Ansible. The control machine can be your local machine or a dedicated server. It should be a Unix-like system (e.g., Linux, macOS) or a Windows system with Windows Subsystem for Linux (WSL) installed.
1. `Python`: Ansible is written in Python, so you'll need Python installed on your control machine. Most Linux distributions come with Python pre-installed. For Windows, you can download and install Python from the official website (https://www.python.org).
1. `SSH`: Ansible communicates with managed hosts over SSH. Ensure that SSH is installed and properly configured on both the control machine and the managed hosts.
1. Alternatively, you can use a customized build `Docker` image that has all the required software installed.

## pve_onboard shell

```shell
bash -c "$(wget -qLO - https://raw.githubusercontent.com/karlcc/Proxmox/737359384e25d9a59c72981f399ff3e126c4ec42/misc/pve_onboard.sh)"
```
