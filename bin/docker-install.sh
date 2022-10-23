#!/bin/bash

os_version=$(lsb_release -d | awk -F"\t" '{print $2}' | awk '{print $1}')

if [ "$os_version" = "Ubuntu" ]; then
	which docker
	if [ $? -eq 0 ]; then
		echo "Docker is already installed on this instance so exiting the process."
		exit 1
	else
		echo "Docker is not installed on this instance so installing the docker pkg's"
		apt-get update -y
		apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key --keyring /usr/share/keyrings/docker-archive-keyring.gpg add
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		apt-get update -y
		apt-get install docker-ce docker-ce-cli containerd.io -y

cat <<EOF | sudo tee /etc/docker/daemon.json
{
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts": {
"max-size": "100m"
},
"storage-driver": "overlay2"
}
EOF

		systemctl enable docker && systemctl daemon-reload && systemctl restart docker && systemctl status docker
	fi

else
	echo "ERROR: This instance is not a Ubuntu OS so halting the installation process"
	exit 1
fi
