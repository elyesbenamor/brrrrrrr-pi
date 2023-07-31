# Join worker nodes to the cluster
echo "[Task 10]: Install sshpass"
sudo apt install -y  sshpass > /dev/null 2>&1

echo "[Task 11]: Copy join command"
sshpass -p "vagrant" scp -p -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@master.example.com:/home/vagrant/joincluster.sh /home/vagrant/joincluster.sh > /dev/null 2>&1

echo "[Task 12]: Join node to the cluster"
sudo bash /home/vagrant/joincluster.sh >/dev/null 2>&1