echo "[Task 10]: Pull required container images"
export KUBERNETES_VER="1.26.1"
kubeadm config images pull --kubernetes-version=$KUBERNETES_VER 


echo "[Task 11]: Initialize control plane"    #### check the version warning here                   
sudo kubeadm init --apiserver-advertise-address=192.168.1.34 --pod-network-cidr=172.16.0.0/24 | sudo tee /var/log/kubeinit.log


echo "[Task 12]:  Configure Calico network plugin"
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml --kubeconfig=/etc/kubernetes/admin.conf 

sleep 30
kubectl set env daemonset/calico-node -n kube-system IP_AUTODETECTION_METHOD=can-reach=www.google.com --kubeconfig=/etc/kubernetes/admin.conf

kubectl rollout restart daemonset calico-node -n kube-system --kubeconfig=/etc/kubernetes/admin.conf

echo "[Taks 13] Copy config file to synced folder"
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config