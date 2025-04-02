#!/bin/bash

sudo apt update -y
sudo apt install curl build-essential git -y

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs

node -v
npm -v

cd /home/ubuntu
git clone https://github.com/cloudhein/express-js-backend.git
sudo chown -R $(whoami):$(whoami) /home/ubuntu/express-js-backend/express-backend
cd express-js-backend/express-backend


# install dependencies
sudo npm install 

# start the server
nohup sudo node index.js &

