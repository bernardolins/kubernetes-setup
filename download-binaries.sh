#!/bin/bash

VERSION=v1.1.2

mkdir -p /opt/bin

ARCH=linux; wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/${ARCH}/amd64/kubelet
ARCH=linux; wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/${ARCH}/amd64/hyperkube

chmod +x hyperkube kubelet
mv hyperkube kubelet /opt/bin
