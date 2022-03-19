# Kubernetes (k3s)

### Installation

```
curl -sfL https://get.k3s.io | sh -
```

### Routing configuration

```
sudo iptables -I INPUT 3 -s 10.42.0.0/16 -j ACCEPT
sudo iptables -I INPUT 3 -d 10.42.0.0/16 -j ACCEPT
```
ou
```
sudo iptables -I INPUT 3 -s 10.43.0.0/16 -j ACCEPT
sudo iptables -I INPUT 3 -d 10.43.0.0/16 -j ACCEPT
```

### Configure KUBECONFIG

```
sudo chown gpenaud:gpenaud /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

### Local images repository

```
cd CAGETTE_IMAGE_REPO
docker build -t cagette:1.0.0 .
docker save --output cagette-1.0.0.tar cagette:1.0.0
sudo k3s ctr images import cagette-1.0.0.tar
```

### uninstall and install cagette

```
helm uninstall cagette && helm uninstall mysql && sudo rm -rf /mnt/k3s-data/*
helm install cagette cagette && helm install mysql mysql
```

### helpers

```
apt update && \
apt install -y \
  default-mysql-client \
  iputils-ping \
  vim
```

```
mysql -h mysql -u docker -pdocker -D db
```
