#!/bin/bash

echo "Creating configmap for Fluentd"
kubectl create configmap fluentd-config --from-file ~/fluentd-setup/conf/fluentd-configmap.conf

echo "Creating Daemonset for Fluentd"
kubectl apply -f ~/fluentd-setup/conf/fluentd-ds.yaml

echo "Creating Service for Fluentd"
kubectl apply -f ~/fluentd-setup/conf/fluentd-ds-svc.yaml
