echo "running apt-get"
sudo apt-get update >/dev/null 2>&1
sudo apt-get install -y git >/dev/null 2>&1
sudo apt-get install -y curl >/dev/null 2>&1
sudo apt-get install -y build-essential >/dev/null 2>&1
sudo apt-get install -y libssl-dev >/dev/null 2>&1

echo "running curl to install nvm"
curl https://raw.githubusercontent.com/creationix/nvm/v0.5.1/install.sh | sh  #>/dev/null 2>&1

echo "reloading profile"
source ~/.profile

echo "using node 0.10.6"
nvm install 0.10.6
nvm alias default 0.10.6
