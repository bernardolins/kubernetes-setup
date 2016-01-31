#!/bin/bash

function printUsage {
  echo -e "A tool to help install kubernetes on a CoreOS machine following this guide: https://coreos.com/kubernetes/docs/latest/getting-started.html"
  echo -e "\n"
  echo -e "Usage:"
  echo -e "\t--role -r\t\t\tRole of the machine on kubernetes cluster. Possible values: master/worker"
  echo -e "\t--ip -i\t\t\t\tMachine ip. Possible values are any valid Ip address"
  echo -e "\t--kube-version -v\t\tVersion of kubernetes. Possible values are any valid kubernetes version"
  echo -e "\t--fqnd -f\t\t\tFully Qualified Domain Name of node. Mandatory on workers. Possible values are any valid fqdn"
}

args=$(getopt -l "role:ip:kube-version:fqdn:help" -o "r:i:v:f:h" -- "$@")

eval set -- "$args"

while [ $# -ge 1 ]; do
  case "$1" in
    --)
      # No more options left.
      shift
      break
      ;;
    -r|--role)
      role="$2"
      shift
      ;;
    -i|--ip)
      ip="$2"
      shift
      ;;
    -v|--kube-version)
      version="$2"
      shift
      ;;
    -f|--fqdn)
      fqdn="$2"
      shift
      ;;
    -h|--help)
      printUsage
      exit 0
      ;;
  esac
  shift
done

if [ $role ]; then
  if [[ $role != "master" && $role != "worker" ]]; then
    echo "---- Wrong role argument! Try 'master' or 'worker'"
    exit 1
  fi

  if [ $role == "worker" ]; then
    if [ ! $fqdn ]; then
      echo "---- Worker must have fqdn (fully qualified domain name)"
      printUsage
      exit 1
    fi      
  fi
else
  echo "---- Must specify a role!"
  printUsage
  exit 1
fi

if [ ! $version ]; then
  echo "---- Must specify a version!"
  printUsage
  exit 1
fi

echo "---- Installing a kubernetes $role version $version, with Ip address $ip"

mkdir -p /opt/bin

echo "---- Downloading binaries"
ARCH=linux; wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/${ARCH}/amd64/kubelet
ARCH=linux; wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/${ARCH}/amd64/hyperkube

chmod +x hyperkube kubelet
mv hyperkube kubelet /opt/bin

source ${role}/generate-ssl.sh
