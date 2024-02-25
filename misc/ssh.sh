ssh-keygen -t rsa

ssh-copy-id -i $HOME/.ssh/id_rsa.pub root@10.10.2.1

# test
echo "foo" > /tmp/foo.txt && scp /tmp/foo.txt root@10.10.2.1:/tmp/

# add user
sudo adduser ansible

# user@ubuntu-server:~$ groups user
# user : user adm cdrom sudo dip plugdev lxd

sudo usermod -aG adm,cdrom,sudo,dip,plugdev,lxd ansible 

# keygen without passphrase
ssh-keygen -t ed25519 -f ~/.ssh/ansible-key -N "" -q
cat ~/.ssh/ansible-key.pub
# ansible@ubuntu-server:~$ cat ~/.ssh/ansible-key.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIiLk4bu58TwhnVr04gS4Pk4nl6UNhcyVt0wRpTHOJqp ansible@ubuntu-server

ssh -i ~/.ssh/ansible-key ansible@10.10.2.1

paste pub key to pve_onboard.yml

mkdir files

echo "ansible ALL=(ALL) NOPASSWD: ALL" > files/sudoer_ansible

ansible-playbook pve_onboard.yml -i inventory --user=root -k