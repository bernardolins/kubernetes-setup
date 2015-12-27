#!/bin/bash

KUBE_DIRECTORY="/etc/kubernetes"
SYSTEMD_DIRECTORY="/etc/systemd/system"
ENVIRONMENT_FILE="kubernetes.env"
SERVICE_FILES=("kube-api-server.service" "kube-controller-manager.service" "kube-proxy.service" "kube-scheduler.service" "kubelet.service")


function create_kube_directory {
  echo "Creating kubernetes directory at $KUBE_DIRECTORY"
  mkdir -p $KUBE_DIRECTORY
}

function add_environment_file {
  echo "Copying environment file to $KUBE_DIRECTORY/$ENVIRONMENT_FILE"
  if [ ! -e "$KUBE_DIRECTORY/$ENVIRONMENT_FILE" ]; then
    ln -s "$(pwd)/$ENVIRONMENT_FILE" "$KUBE_DIRECTORY/$ENVIRONMENT_FILE"
  fi
}

function copy_systemd_unit_files {
  for file in ${SERVICE_FILES[@]}; do
    if [ ! -e "$SYSTEMD_DIRECTORY/$file" ]; then
      echo "Copying $file to $SYSTEMD_DIRECTORY"
      ln -s "$(pwd)/$file" "$SYSTEMD_DIRECTORY/$file"
    fi
  done
}

create_kube_directory
add_environment_file
copy_systemd_unit_files

