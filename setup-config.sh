#!/bin/bash

$KUBE_DIRECTORY="/etc/kubernetes"
$SYSTEMD_DIRECTORY="/etc/systemd/system"

if [ !-d $KUBE_DIRECTORY ]; then
  mkdir -p $KUBE_DIRECTORY
fi

ln -s $(pwd)/kubelet.env $KUBE_DIRECTORY
ln -s $(pwd)/kube-* $SYSTEMD_DIRECTORY
