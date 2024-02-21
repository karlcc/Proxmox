      USERNAME="ansible"
      
      echo "Creating user ${USERNAME}"
      pveum useradd ${USERNAME}@pam
      pveum group add admin -comment "System Administrators"
      pveum acl modify / -group admin -role Administrator
      pveum user modify ${USERNAME}@pam -group admin

      echo "Creating api token for ${USERNAME}"
      API_TOKEN=$(pveum user token add ${USERNAME}@pam token --privsep 0)

      echo "Saving"
      echo "${API_TOKEN}" > ansible_token.txt
      echo ${API_TOKEN}
      echo "Done"


USERNAME="ansible"
PASSWORD="ansible"
echo "Deleting user ${USERNAME}"
pveum user delete ${USERNAME}@pam
echo "Creating user ${USERNAME}"
pveum useradd ${USERNAME}@pam --password ${PASSWORD}