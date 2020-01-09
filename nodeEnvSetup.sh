#!/bin/bash
echo "                          Installing Node Environment"
echo -e "\n\n"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
sudo /home/$USER/.nvm/install.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm ls-remote
echo "Enter a Node version from the above list to install:"
read nv
echo "Installing Node $nv"
nvm install $nv
nvm use $nv
echo -e "\n\n"

