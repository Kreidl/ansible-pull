#/bin/sh

#Install pip which is needed for ansible
sudo apt-get install -y python-pip

#Install ansible with pip
sudo pip install --user ansible
sudo apt-get install -y software-properties-common git
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

#Create directory
sudo mkdir -p /etc/ansible

cd /etc/ansible

sudo git clone https://github.com/Kreidl/ansible-pull .

sudo crontab -u root -l
0 5 0 ? * * * ./node-runner.sh
