#!/bin/bash

# swap file creation
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
swapon --show
free -h
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Install nodejs packages
sudo apt update -y
sudo apt install curl build-essential git -y

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs

node -v
npm -v

git clone git@github.com:cloudhein/MERN-App-Deploy.git
cd react-frontend


# express server ip substitution
sed -i "s/^REACT_APP_SERVER_IP=.*$/REACT_APP_SERVER_IP=${aws_instance.backend_server.public_ip}/" .env

# Install yarn package manager
sudo npm install -g yarn

# installing dep
NODE_OPTIONS="--max-old-space-size=4096" sudo yarn install --production

# starting the server
nohup sudo yarn start &