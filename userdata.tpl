#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo apt install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ubuntu &&
curl -fsSOL https://go.dev/dl/go1.18.1.linux-amd64.tar.gz &&
sudo tar -C /usr/local -xvf go1.18.1.linux-amd64.tar.gz &&
sudo echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
