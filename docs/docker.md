# docker compose
>docker-compose.yml
```yml
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
```dockerfile
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
