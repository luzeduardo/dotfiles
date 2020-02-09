#!/bin/bash
title () {
   echo "********************************************************"
   echo "********************************************************"
   echo "$1******************************************************"
   echo "********************************************************"
   echo "********************************************************"
}
ssh-keygen -t rsa -N '' -C "luz.eduardo@gmail.com"
ssh-add ~/.ssh/id_rsa

cd ~
#dotfiles config
mkdir -p ~/code && git clone https://github.com/luzeduardo/dotfiles ~/code/dotfiles
cd ~/code/dotfiles 
git remote rm origin && git remote add origin git@github.com:luzeduardo/dotfiles
cd ~

mkdir -p /usr/local/bin

title "gpg"
if [[ "$(which gpg)" == '' ]]; then
  sudo yum install -y gnupg
fi
title "gpg-END"

title "ssh"
sudo -u $USER cp ~/dotfiles/fedora/known_hosts.gpg ~/.ssh/known_hosts.gpg
sudo -u $USER cp ~/dotfiles/fedora/id_rsa.pub.gpg ~/.ssh/id_rsa.pub.gpg
if [ ! -d "~/.ssh" ]; then
    mkdir -p "~/.ssh"
fi
cd ~/.ssh
sudo -u $USER gpg -d ~/.ssh/known_hosts.gpg
sudo -u $USER gpg -d ~/.ssh/id_rsa.pub.gpg
title "ssh-END"

cd ~

sudo dnf -y update
sudo dnf -y install  neovim python3-neovim
sudo dnf -y install git vim gvim terminator udisks wget
sudo dnf -y install gnome-tweak-tool dnf-plugins-core openssh-server
sudo dnf -y install wget make autoconf texinfo
sudo dnf -y install npm
sudo dnf -y install zlib-devel bzip2 bzip2-devel readline-devel openssl-devel xz xz-devel bison bison-devel glibc-devel binutils gcc autoconf automake gcc-c++ libffi-devel libtool sqlite-devel libyaml-devel xclip
sudo dnf -y install deluge
sudo dnf -y install jq

title "flutter"
if [[ "$(which flutter)" == '' ]]; then
  wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.5-stable.tar.xz
  mkdir -p code
  cd code
  tar xf ~/flutter_linux_v1.12.13+hotfix.5-stable.tar.xz
  export PATH="$PATH:`pwd`/flutter/bin"
  #flutter doctor
fi
title "flutter-END"

# ranger (and utilities for previewing files)
title "utils"
sudo dnf -y install ranger caca-utils highlight atool w3m poppler-utils mediainfo alsa-lib-devel
title "utils-END"

title "shell"
sudo dnf install -y htop curl httpie bash bash-completion tmux vim
title "shell-END"

title "laptop"
sudo dnf -y install acpi powertop tlp xdotool recode
title "laptop-END"

#translate shell
title "translateshell"
if [[ "$(which trans)" == '' ]]; then
  sudo dnf -y install translate-shell
fi
title "translateshell-END"

#git flow
title "gitflow"
if [[ "$(which gitflow)" == '' ]]; then
  sudo dnf install -y gitflow
fi
title "gitflow-END"

#package manager
title "snapd"
if [[ "$(which snap)" == '' ]]; then
  sudo dnf install -y snapd
  sudo ln -s /var/lib/snapd/snap /snap
fi
title "snapd-END"

#silver searcher
title "silversearcher"
sudo dnf install -y the_silver_searcher
title "silversearcher-END"

# Java
title "java"
if [[ "$(which java)" == '' ]]; then
  sudo dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel
fi
title "java-END"

# misc cmd line tools
title "swish-e catalog"
sudo dnf -y install pass swish-e
title "swish-e catalog-END"

title "zsh"
sudo dnf -y install zsh
grep $USER /etc/passwd
chsh -s $(which zsh)
grep $USER /etc/passwd
title "zsh-END"

git config --global user.name "Eduardo Luz"
git config --global user.email "luz.eduardo@gmail.com"
git config --global push.default simple


#ngrok
title "NGROK"
NGROK_IS_AVAILABLE="$(ngrok -version 2>&1 >/dev/null)"
if [[ ${NGROK_IS_AVAILABLE} == '' ]]; then
    echo -e "${bakgrn}[installed][ngrok]${txtrst} already installed ;)" ;
else
    echo -e "${bakcyn}[ngrok] Start Install ${txtrst}";
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
    unzip ngrok-stable-linux-amd64.zip
    sudo mv ngrok /usr/bin/ngrok
    sudo chmod +x /usr/bin/ngrok
    rm -rf ngrok-stable-linux-amd64.zip
    echo -e "${bakgrn}[ngrok] Finish Install ${txtrst}";
fi
#ngrok
title "NGROK-END"

#vscode
title "vscode"
if [[ "$(which code)" == '' ]]; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  sudo dnf install -y code
  cat ~/dotfiles/fedora/vscode/extensions.list | xargs -L 1 code --install-extension
  cp ~/dotfiles/fedora/vscode/settings.user ~/.vscode/
fi
title "vscode-END"

#vim
title "vim"
git clone git@github.com:luzeduardo/vimconf.git
cd ~/vimconf
make install
cd ~
title "vim-END"

title "skype"
sudo curl -o /etc/yum.repos.d/skype-stable.repo https://repo.skype.com/rpm/stable/skype-stable.repo
sudo dnf install skypeforlinux
title "skype - END"

# dmenu with ^M working as Return
git clone https://github.com/goldfeld/dmenu ~/dmenu
cd ~/dmenu && make && sudo make install && cd ~

# vroom (vim testing)
cd && git clone https://github.com/google/vroom ~/qfork/vroom

# rust
if [[ "$(which rustup)" == '' ]]; then
  curl https://sh.rustup.rs -sSf | sh
fi

#js
title "js"
if [[ "$(which nvm)" == '' ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
  nvm list
  export NVM_DIR="$HOME/.nvm" [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm\n[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm list
fi
title "js-END"

#node
title "node"
if [[ "$(which node)" == '' ]]; then
  sudo snap install node --classic
fi
title "node-END"

#python
title "python"
python3 setup.py build && sudo python3 setup.py install
title "python-END"

title "nodemon httpserver commitizen"
if [[ "$(which nodemon)" == '' ]]; then
  sudo npm install -g http-server nodemon commitizen
fi
title "nodemon httpserver END"

# virtualbox
title "virtualbox"
if [[ "$(which virtualbox)" == '' ]]; then
  sudo wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -P /etc/yum.repos.d/
  sudo dnf -y install @development-tools
  sudo dnf install -y kernel-devel kernel-headers dkms qt5-qtx11extras  elfutils-libelf-devel zlib-devel
  sudo dnf -y install VirtualBox-6.0
  usermod -a -G vboxusers $USER
fi
title "virtualbox END"

# sudo dnf -y groupinstall "GNOME Desktop"

# exercism config
title "exercism"
if [[ "$(which exercism)" == '' ]]; then
  wget https://github.com/exercism/cli/releases/download/v3.0.13/exercism-3.0.13-linux-x86_64.tar.gz
  tar -xf exercism-linux-64bit.tgz
  mkdir -p ~/bin
  mv exercism ~/bin
  
  exercism configure --token=a8e70d9c-94f4-4ac0-9245-4af5c949e187
fi
title "exercism END"

 #yarn
 title "yarn"
 if [[ "$(which yarn)" == '' ]]; then
  curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
  sudo yum install -y yarn
 fi
 title "yarn-END"
  
 #brave browser
 title "brave"
 if [[ "$(which brave)" == '' ]]; then
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf install -y brave-browser
 fi
 title "brave-END"
   
 #tile screen manager 
 #sudo dnf install i3 i3st1atus dmenu i3lock xbacklight feh conky
 title "tile"
 git clone https://github.com/gTile/gTile.git ~/.local/share/gnome-shell/extensions/gTile@vibou
 title "tile-END"

# pdf to kindle converter
# https://www.willus.com/k2pdfopt/download/
# calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

#docker
title "docker"
DOCKER_IS_AVAILABLE="$(docker -v 2>&1 >/dev/null)"
if [[ ${DOCKER_IS_AVAILABLE} == '' ]]; then
    echo -e "${bakgrn}[installed][Docker]${txtrst} already installed ;)" ;
else
	# echo -e "${bakcyn}[Docker] Start Install ${txtrst}";
  # dnf -y install dnf-plugins-core
  # dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  # dnf config-manager --set-enabled docker-ce-edge
  # dnf config-manager --set-enabled docker-ce-test
  # dnf install -y docker-ce
	# service docker start
	# usermod -aG docker $USER
	# chkconfig docker on
	# echo -e "${bakgrn}[Docker] Finish Install ${txtrst}";

  sudo snap install docker
fi
#docker
title "docker-END"

#mongo
title "mongo"
MONGO_IS_AVAILABLE="$(dnf list installed | grep mongodb)"
if [[ ${MONGO_IS_AVAILABLE} != '' ]]; then
  echo -e "${bakgrn}[installed][MongoDB]${txtrst} already installed ;)" ;
else
	echo -e "${bakcyn}[MongoDB] Start Install ${txtrst}";
  sudo dnf install -y mongodb mongodb-server
	echo -e "${bakgrn}[MongoDB] Finish Install ${txtrst}";
fi
#mongo
title "mongo-END"

#vlc
title "vlc"
if [[ -e /usr/bin/vlc ]]; then
  echo -e "${bakgrn}[installed][VLC]${txtrst} already installed ;)" ;
else
  echo -e "${bakcyn}[VLC] Start Install ${txtrst}";
  rpm -ivh https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install -y vlc python-vlc npapi-vlc
  echo -e "${bakgrn}[VLC] Finish Install ${txtrst}";
fi
#vlc
title "vlc-END"

title "postman"
if [[ "$(which postman)" == '' ]]; then
  sudo snap install postman
fi
title "postman-END"

title "slack"
if [[ "$(which slack)" == '' ]]; then
  sudo snap install slack --classic
fi
title "slack-END"


#pretzo
title "pretzo"
if [[ "$(which pretzo)" == '' ]]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
  chsh -s /bin/zsh
fi
title "pretzo-END"

rm ~/.bashrc
ln -s ~/dotfiles/fedora/bashrc ~/.bashrc
ln -s ~/dotfiles/fedora/zshrc ~/.zshrc
ln -s ~/dotfiles/fedora/zshenv ~/.zshenv
ln -s ~/dotfiles/fedora/zpretzorc ~/.zpretzorc


. ts.sh
. langservers.sh



#flutter
#android studio
#stremio
