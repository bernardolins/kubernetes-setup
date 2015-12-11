#!/bin/bash

KUBE_DIRECTORY="/etc/kubernetes"
SYSTEMD_DIRECTORY="/etc/systemd/system"
ENVIRONMENT_FILE="kubernetes.env"
PWD=$(pwd)

SERVICE_FILES=("kube-api-server.service" "kube-controller-manager.service" "kube-proxy.service" "kube-scheduler.service" "kubelet.service")

if [ -e "$KUBE_DIRECTORY/$ENVIRONMENT_FILE" ]; then
  rm -rf "$KUBE_DIRECTORY/$ENVIRONMENT_FILE"
fi

for file in ${SERVICE_FILES[@]}; do
  if [ -e "$SYSTEMD_DIRECTORY/$file" ]; then
    rm -rf "$SYSTEMD_DIRECTORY/$file"
    echo "$SYSTEMD_DIRECTORY/$file"
  fi
done
