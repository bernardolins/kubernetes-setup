#!/bin/bash

KUBE_DIRECTORY="/etc/kubernetes"
SYSTEMD_DIRECTORY="/etc/systemd/system"
ENVIRONMENT_FILE="kubernetes.env"

SERVICE_FILES=("kube-api-server.service" "kube-controller-manager.service" "kube-proxy.service" "kubelet.service")

if [ -e KUBE_DIRECTORY/ENVIRONMENT_FILE ]; then
  rm -s $(pwd)/kubelet.env KUBE_DIRECTORY
fi

for file in ${SERVICE_FILES[@]}; do
  if [ -e SYSTEMD_DIRECTORY/file ]; then
    rm -rf SYSTEMD_DIRECTORY/file
  fi
done
