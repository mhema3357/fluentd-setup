#!/bin/bash

curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt update -y

apt-get install -y kubelet kubeadm kubectl


systemctl enable kubelet

systemctl daemon-reload

kubeadm init --cri-socket=unix:///run/cri-dockerd.sock

sleep 30
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf

echo "Setting up N/W for Kubernetes Pods using Calico"
kubectl apply -f ~/fluentd-setup/conf/calico.yaml

apt install bash-completion && source <(kubectl completion bash) && echo "source <(kubectl completion bash)" >> ~/.bashrc

echo "Checking the cluster status"

kubectl cluster-info

echo "Tainting the node to get pods scheduled on sane test setup"
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
