# pvesh create access/users --userid ansible@pam
pveum useradd ansible@pam
# pveum user token add ansible@pam ansible_token --privsep 0
pveum passwd ansible@pam Passw0rd
pveum group add admin -comment "System Administrators"
pveum acl modify / -group admin -role Administrator
pveum user modify ansible@pam -group admin


curl -k -d 'username=ansible@pam' --data-urlencode 'password=ansible' https://10.10.2.1:8006/api2/json/access/ticket