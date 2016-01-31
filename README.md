### Setup Kubernetes cluster

#### Usage

If you want a master machine:

```bash
./kube-install.sh --role master --kube-version v1.1.2 --ip 192.168.0.10
```

Or even a worker

```bash
./kube-install.sh --role worker --kube-version v1.1.2 --ip 192.168.0.11
```

#### How it works
1. The script will download binaries, move it to /opt/bin directory (It will be created if doesn't exist).
2. Then, SSL certificates will be generated. If you are setting up a worker, you must copy the root certificate (ca.pem) to your worker machine.
3. Lastly, it will copy systemd service files to /etc/system/systemd and start the units.

#### Configuration
This repository comes with some default unit files. If you want to use your own unit file, place them at /$role/templates/ directory.

#### Roadmap
1. Support to docker
2. Improve customized configuration support
