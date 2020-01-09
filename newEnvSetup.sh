#!/bin/bash

echo "Configuring new environment for the user : $USER"
echo -e "\n"
echo "OS Details:"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
lsb_release -d
lsb_release -r
lsb_release -c
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""
echo "Installing:
> Curl
> Ruby
> MongoDB
> Python3 Dependencies & Modules
> NVM & Node
> Sublime Text 3
> Not using R"
echo "----------------------------------------------------------------------------------------------------------------------"
echo -e "\n"

echo "Updating System..."
sudo apt-get -y update

echo -e "\n"
echo "Installing Curl if it doesn't already exist"
echo ""
sudo apt-get -y install curl
echo "----------------------------------------------------------------------------------------------------------------------"
echo "				Installing RVM"
echo -e "\n"
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

\curl -sSL https://get.rvm.io | bash

source ~/.bashrc
source ~/.bash_profile

#rvm get stable --auto-dotfiles
source /home/deploy/.rvm/scripts/rvm
which rvm
rvm -v

echo -e "\n"
echo "Enter the Ruby version you wish to install(Ex:- 2.2.2) :"
read rv
#rv=2.2.2
rvm install $rv 
rvm use $rv --default
echo -e "\n\n"
echo "Ruby Installation Completed..!!"
echo "if ruby is still not found, source ~/.bashrc and then use command rvm use 2.2.2"
echo "----------------------------------------------------------------------------------------------------------------------"
echo -e "\n"
source ~/.bashrc
rvm use $rv
which ruby

echo "				Installing MongoDB"
sudo apt-get install -y mongodb
sudo systemctl status mongodb --no-pager

echo -e "\n\n"
echo "If the mongodb.service is 'Active', MongoDB is successfully installed and running. Else Install it manually."
echo "----------------------------------------------------------------------------------------------------------------------"
echo ""
echo "				Installing Python3.x Dependencies"
echo ""
echo "		Installing pip 3"
echo ""
echo "Note: Use pip3 to install python3 packages. EX: pip3 install sklearn"
echo ""
sudo apt-get -y install python3-pip
echo -e "\n"
echo "		installing tkinter"
sudo apt-get install -y python3-tk
echo -e "\n\n"
echo "Now installing the following Packages: numpy, scipy, scikit-learn, pandas, watchdog, pymongo, stats, matplotlib, keras & tensorflow"
pip3 --default-timeout=10000 install stats numpy scipy sklearn pandas watchdog pymongo tensorflow matplotlib keras seaborn

echo -e "\n\n"
echo "Python3.x environment setup complete..!!"
echo "----------------------------------------------------------------------------------------------------------------------"
echo "				Installing Node Environment"
echo -e "\n\n"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
sudo /home/$USER/.nvm/install.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm ls-remote --lts
echo "Enter a Node version from the above list to install: 10.15.3"
read nv
#nv=10.15.3
echo "Installing Node $nv"
nvm install $nv
nvm use $nv
echo "Installing Angular CLI version 7.3.5"
npm install @angular@7.3.5
echo -e "\n\n"
echo "----------------------------------------------------------------------------------------------------------------------"
echo				Now installing Sublime Text 3
echo -e "\n\n"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
echo "Sublime Text 3 Successfully installed"
echo "----------------------------------------------------------------------------------------------------------------------"
echo				NOT Installing R 3.x
echo -e "\n\n\n"
#sudo apt-get install -y libcurl4-openssl-dev libxml2-dev libssl-dev
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
#sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
#sudo apt-get update
#sudo apt-get install -y r-base
#Rscript -e 'install.packages(c("drat","plyr", "dplyr", "stringi", "stringr", "tidyr", "tictoc", "chron", "zoo", "lubridate", "utils", "tcltk", "rvest", "keras", "tensorflow"), dependencies = TRUE)'
#R --version
#source ~/.bashrc
#source ~/.bash_profile
echo "----------------------------------------------ENVIRONMENT SETUP COMPLETED---------------------------------------------"

source ~/.bashrc

echo "installing apache2"
sudo apt-get update
sudo apt-get install apache2 -y
sudo systemctl status apache2



