# Fluentd Setup on Sandbox using Kubernetes
* This is simple setup for running fluentd on Ubuntu OS *
### Installation 
* Installation involves in four steps *

Step - 1:
- Run basic docker installtion
```console
foo@bar:~$ sudo sh ~/fluentd-setup/bin/docker-install.sh
```
Step - 2:
- Run cri-docker installation
```console
foo@bar:~$ sudo sh ~/fluentd-setup/bin/cri-docker-install.sh
```
Step - 3:
- Run basic kubeadm setup
```console
foo@bar:~$ sudo sh ~/fluentd-setup/bin/kubernetes-install.sh
```
Step - 4:
- Deploy fluentd into kubernetes cluster
```console
foo@bar:~$ sh ~/fluentd-setup/bin/fluentd-k8s-setup.sh
```
