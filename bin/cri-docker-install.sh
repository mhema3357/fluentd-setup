#!/bin/bash

echo "Downloading the source from github"
wget -o /tmp https://github.com/Mirantis/cri-dockerd/releases/download/v0.2.6/cri-dockerd-0.2.6.amd64.tgz

echo "Untarring the cri-docker and moving the binary to bin location"
tar -zxvf /tmp/cri-dockerd-0.2.6.amd64.tgz && mv /tmp/cri-dockerd /usr/bin/

echo "Generating cri-docker service file"
cat << EOF | tee /etc/systemd/system/cri-docker.service 
[Unit]
Description=CRI Interface for Docker Application Container Engine
Documentation=https://docs.mirantis.com
After=network-online.target firewalld.service docker.service
Wants=network-online.target
Requires=cri-docker.socket
[Service]
Type=notify
ExecStart=/usr/bin/cri-dockerd/cri-dockerd --container-runtime-endpoint fd:// --network-plugin=cni --cni-bin-dir=/opt/cni/bin --cni-cache-dir=/var/lib/cni/cache --cni-conf-dir=/etc/cni/net.d
ExecReload=/bin/kill -s HUP $MAINPID
TimeoutSec=0
RestartSec=2
Restart=always
StartLimitBurst=3
StartLimitInterval=60s
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
Delegate=yes
KillMode=process
[Install]
WantedBy=multi-user.target
EOF

echo "Generating cri-docker.socket unit file"
cat << EOF | tee /etc/systemd/system/cri-docker.socket
[Unit]
Description=CRI Docker Socket for the API
PartOf=cri-docker.service
[Socket]
ListenStream=%t/cri-dockerd.sock
SocketMode=0660
SocketUser=root
SocketGroup=docker
[Install]
WantedBy=sockets.target
EOF

echo "Reloading the new cri-docker unitfiles"
systemctl daemon-reload && systemctl enable cri-docker.service && systemctl enable --now cri-docker.socket

echo "Restarting cri-docker service and verifying service status"
systemctl restart cri-docker.service && systemctl status cri-docker.service && systemctl status cri-docker.socket 
