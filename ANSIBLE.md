# Requirements
>Before you start with Ansible, you'll need the following:
- Control Machine: Ansible is agentless, which means you don't need to install any software on the managed hosts. Instead, you need a control machine from which you'll run Ansible. The control machine can be your local machine or a dedicated server. It should be a Unix-like system (e.g., Linux, macOS) or a Windows system with Windows Subsystem for Linux (WSL) installed.
- or Using customized build docker image.

## Docker
>docker-compose.yml
```yaml
version: '3.8'

services:
  ansible-runner:
    build:
      context: .
      dockerfile: Dockerfile.ansible
    container_name: ansible-runner
    command: sh -c "ansible-runner worker && tail -f /dev/null"
    volumes:
    - ./demo:/runner
    environment:
    - ANSIBLE_CONFIG=/runner/ansible.cfg

```
>Dockerfile.ansible
```Dockerfile
FROM ghcr.io/ansible-community/community-ee-base:latest

# Switch to root user to perform privileged operations
USER root

# Create a user with UID 1000
RUN useradd -m -u 1000 ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/1000

# Switch back to the non-root user (if any)
USER ansible

# Run ssh-keygen to generate Ed25519 SSH key pair
RUN ssh-keygen -t ed25519 -f /home/ansible/.ssh/ansible-key -N "" -q
```

## ansible-playbook

>create ansible-playbook<br>
>create ansible.cfg<br>
>create inventory<br>

>test connection using root user with remote node password
```bash
ansible proxmox_labs -i ./inventory -m ping -u root -k
```
>config remote node using root user
```bash
ansible-playbook pve_onboard.yml -i inventory -u root -k -l proxmox_labs
```
>pve_onboard.yml
```yaml
- hosts: proxmox_labs:all
  tasks:

  - name: Remove specified repository from sources list
    ansible.builtin.apt_repository:
      repo: deb https://enterprise.proxmox.com/debian/pve bookworm pve-enterprise
      state: absent
      filename: pve-enterprise
      update_cache: false
      
  - name: Add specified repository into sources list using specified filename
    ansible.builtin.apt_repository:
      repo: deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
      state: present
      filename: pve-install-repo
      update_cache: false

  - name: Remove specified repository from sources list
    ansible.builtin.apt_repository:
      repo: deb https://enterprise.proxmox.com/debian/ceph-quincy bookworm enterprise
      state: absent
      filename: ceph
      update_cache: false

  - name: Add specified repository into sources list using specified filename
    ansible.builtin.apt_repository:
      repo: deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription
      state: present
      filename: ceph
      update_cache: false

  - name: install sudo package
    apt:
      name: sudo
      update_cache: yes
      cache_valid_time: 3600
      state: latest

  - name: create Ansible user
    user:
      name: ansible
      shell: '/bin/bash'

  - name: add Ansible ssh key
    authorized_key:
      user: ansible
      key: "{{ lookup('file', '/home/ansible/.ssh/ansible-key.pub') }}"

  - name: add ansible to sudoers
    copy:
      src: sudoer_ansible
      dest: /etc/sudoers.d/ansible
      owner: root
      group: root
      mode: 0440
```

>test connection using ansible user with ssh key
```bash
ansible proxmox_labs -m ping -i ./inventory -u ansible --private-key ~/.ssh/ansible-key
```

>update proxmox server using ansible user with ssh key
```bash
ansible-playbook pve_update.yml -i ./inventory -u ansible --private-key ~/.ssh/ansible-key -l proxmox_labs
```
>pve_update.yml
```yaml
- hosts: proxmox_labs:all
  become: yes
  become_user: root

  tasks:
    - name: Update apt-get repo and cache
      apt: update_cache=yes force_apt_get=yes cache_valid_time=3600

    - name: Upgrade all apt packages
      apt: upgrade=dist force_apt_get=yes

    - name: Check if a reboot is needed for Debian and Ubuntu boxes
      register: reboot_required_file
      stat: path=/var/run/reboot-required get_checksum=no

    - name: Reboot the Debian or Ubuntu server
      reboot:
        msg: "Reboot initiated by Ansible due to kernel updates"
        connect_timeout: 5
        reboot_timeout: 300
        pre_reboot_delay: 0
        post_reboot_delay: 30
        test_command: uptime
      when: reboot_required_file.stat.exists
```

>pve_postfix.yml
```yaml
- hosts: proxmox_labs:all

  tasks:
  - name: install libsasl2-modules package
    become: yes
    become_user: root
    apt:
      name: libsasl2-modules
      update_cache: yes
      cache_valid_time: 3600
      state: latest
    notify:
      - postmap sasl_passwd
      - restart postfix

  roles:
     - arillso.postfix
  vars:
    postfix_relayhost: smtp.gmail.com
    postfix_relayhost_port: 587
    postfix_relaytls: true
    postfix_sasl_auth_enabled: true
    postfix_sasl_security_options: noanonymous
    postfix_sasl_user: hello@karldigi.dev
    postfix_sasl_password: <PASSWORD>
```