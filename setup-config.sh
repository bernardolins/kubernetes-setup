#!/bin/bash

KUBE_DIRECTORY="/etc/kubernetes"
SYSTEMD_DIRECTORY="/etc/systemd/system"

SERVICE_FILES=("kube-api-server.service" "kube-controller-manager.service" "kube-proxy.service" "kube-scheduler.service" "kubelet.service")


if [ ! -d $KUBE_DIRECTORY ]; then
  mkdir -p $KUBE_DIRECTORY
fi

ln -s "$(pwd)/kubelet.env" "$KUBE_DIRECTORY/kubelet.env"

for file in ${SERVICE_FILES[@]}; do
  if [ ! -e "$SYSTEMD_DIRECTORY/$file" ]; then
    ln -s "$(pwd)/$file" $SYSTEMD_DIRECTORY
  fi
done
