#!/bin/bash

echo "[TASK 1]: Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
sudo swapoff -a     

echo "[TASK 2]: Stop and Disable firewall"
systemctl disable --now ufw  2>&1

echo "cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1" | sudo tee -a  /boot/firmware/cmdline.txt

echo "[TASK 3]: Add containerd settings"
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter


echo "[TASK 4]: Add kernel network configuration"
cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system > /dev/null 2>&1


echo "[TASK 5]: Update the system & install required packages"
# Update the system
sudo apt-get update -qq -y ; sudo apt-get upgrade -qq -y 2>&1  ################################  system update making a lot of output 
# # Install necessary software
# sudo  apt-get install curl \
#       apt-transport-https \
#       vim \
#       nano \
#       git \
#       wget \
#       gnupg2 \
#       software-properties-common \
#       apt-transport-https \
#       lsb-release \
#       ca-certificates -qq -y 2>&1


echo "[TASK 6] Install containerd runtime"             
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -qq -y 2>&1
sudo apt-get install containerd.io -qq -y 2>&1
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -e 's/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml
sudo systemctl restart containerd 2>&1
sudo systemctl enable containerd 2>&1


echo "[TASK 7]: Install K8s"       ##########   remove apt-key   because it is depricated #################################################################################
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -  
apt-add-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get -qq -y install kubelet=1.26.1-00 kubeadm=1.26.1-00 kubectl=1.26.1-00 2>&1
sudo apt-mark hold kubelet kubeadm kubectl 2>&1
sudo systemctl enable --now kubelet 2>&1




# echo "[TASK 9] Update /etc/hosts file to comply with our setup"
# cat >>/etc/hosts<<EOF
# 192.168.0.202   master.example.com     master
# 192.168.0.201   worker1.example.com    worker1
# 192.168.0.200   worker2.example.com    worker2
# 192.168.0.203   worker2.example.com    worker3
# EOF
sudo reboot