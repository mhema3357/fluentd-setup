# Fluentd Setup on Sandbox using Kubernetes
* This is simple setup for running fluentd on Ubuntu OS *
### Installation 
* Installation involves five steps *

Step - 1:
- Check out fluentd-setup repo
```console
foo@bar:~$ git clone git@github.com:mhema3357/fluentd-setup.git 
```
Step - 2:
- Run basic docker installtion
```console
foo@bar:~$ sudo /bin/sh ~/fluentd-setup/bin/docker-install.sh
```
Step - 3:
- Run cri-docker installation
```console
foo@bar:~$ sudo /bin/sh ~/fluentd-setup/bin/cri-docker-install.sh
```
Step - 4:
- Run basic kubeadm setup
```console
foo@bar:~$ sudo /bin/sh ~/fluentd-setup/bin/kubernetes-install.sh
```
Step - 5:
- Deploy fluentd into kubernetes cluster
```console
foo@bar:~$ /bin/sh ~/fluentd-setup/bin/fluentd-k8s-setup.sh
```
