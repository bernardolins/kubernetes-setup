#!/bin/bash

VERSION=v1.1.2
ROLE="worker"

if [ $1 ]; then
  if [[ $1 == "master" || $1 == "worker" ]]; then
    ROLE=$1 
  else
    echo "---- Wrong argument! Try 'master' or 'worker'"
  fi
fi

echo "---- Installing a kubernetes $ROLE version $VERSION"

mkdir -p /opt/bin

ARCH=linux; wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/${ARCH}/amd64/kubelet
ARCH=linux; wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/${ARCH}/amd64/hyperkube

chmod +x hyperkube kubelet
mv hyperkube kubelet /opt/bin

./${ROLE}/generate-ssl.sh
