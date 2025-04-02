#!/bin/bash

sudo apt update -y
sudo apt install curl build-essential git -y

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs

node -v
npm -v

git clone git@github.com:cloudhein/MERN-App-Deploy.git
cd express-backend

# install dependencies
sudo npm install 

# start the server
nohup sudo node server.js &

