#!/bin/bash

sudo dnf -y update
sudo dnf -y install git vim gvim terminator udisks wget
sudo dnf -y install gnome-tweak-tool dnf-plugins-core openssh-server

sudo dnf -y install wget make autoconf texinfo
sudo dnf -y install npm
git config --global user.name "Eduardo Luz"
git config --global user.email "luz.eduardo@gmail.com"
git config --global push.default simple

title () {
   echo "$1==============================================================================================="
}

# gpg
title "gpg"
sudo yum install gnupg
title "gpg-END"

cp ~/dotfiles/fedora/know_hosts.gpg ~/.ssh/know_hosts.gpg
cp ~/dotfiles/fedora/id_rsa.pub.gpg ~/.ssh/id_rsa.pub.gpg

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

#package manager
title "snapd"
sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap
title "snapd-END"

cd ~
#dotfiles config
git clone https://github.com/luzeduardo/dotfiles
cd ~/dotfiles
git remote rm origin && git remote add origin git@github.com:luzeduardo/dotfiles

mkdir -p /usr/local/bin
mkdir -p ~/code

rm ~/.bashrc
ln -s ~/code/dotfiles/fedora/bashrc ~/.bashrc
ln -s ~/code/dotfiles/fedora/zshrc ~/.zshrc

cd ~

#translate shell
title "translateshell"
sudo dnf -y install translate-shell
title "translateshell-END"

#zsh
title "zsh"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
chsh -s /bin/zsh
title "zsh-END"

#vscode
title "vscode"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install -y code
cat ~/dotfiles/fedora/vscode/extensions.list | xargs -L 1 code --install-extension
cp ~/dotfiles/fedora/vscode/settings.user ~/.vscode/
title "vscode-END"

#git flow
title "gitflow"
sudo dnf install -y gitflow
title "gitflow-END"

#vim
title "vim"
git clone git@github.com:luzeduardo/vimconf.git
cd ~/vimconf
make install
cd ~
title "vim-END"

#silver searcher
title "silversearcher"
dnf install -y zlib-devel bzip2 bzip2-devel readline-devel openssl-devel xz xz-devel bison bison-devel glibc-devel binutils gcc autoconf automake gcc-c++ libffi-devel libtool sqlite-devel libyaml-devel xclip the_silver_searcher
title "silversearcher-END"

# Shell
title "shell"
sudo dnf install htop curl httpie bash bash-completion tmux vim
title "shell-END"

# Laptop
title "laptop"
sudo dnf -y install acpi powertop tlp xclip xdotool recode
title "laptop-END"

title "chrome and other"
sudo dnf -y install \
     google-chrome-stable\
     gnome-tweak-tool\
     gnome-shell-extension-user-theme\
     skypeforlinux\
     telegram-desktop\
     transmission
title "chrome and other-END"

# Java
title "java"
sudo dnf -y install java-1.8.0-oracle java-1.8.0-oracle-devel java-1.8.0-openjdk java-1.8.0-openjdk-devel
title "java-END"

# misc cmd line tools
title "swish-e catalog"
sudo dnf -y install pass swish-e
title "swish-e catalog-END"

# dmenu with ^M working as Return
git clone https://github.com/goldfeld/dmenu ~/dmenu
cd ~/dmenu && make && sudo make install && cd ~

# vroom (vim testing)
cd && git clone https://github.com/google/vroom ~/qfork/vroom

# rust
curl https://sh.rustup.rs -sSf | sh

#js
title "js"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash\n
nvm list
export NVM_DIR="$HOME/.nvm"\n[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm\n[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm list
title "js-END"

#node
title "node"
sudo snap install node --classic
title "node-END"

#python
title "python"
python3 setup.py build && sudo python3 setup.py install
title "python-END"

# ruby
title "ruby"
sudo dnf -y install ruby rubygems
sudy gem install git-bump
title "ruby-END"

# ranger (and utilities for previewing files)
title "utils"
sudo dnf -y install ranger caca-utils highlight atool w3m poppler-utils mediainfo
title "utils-END"

title "nodemon httpserver"
sudo npm install -g http-server nodemon
title "nodemon httpserver END"

sude dnf -y install alsa-lib-devel

# virtualbox
title "virtualbox"
sudo wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -O /etc/dnf.repos.d/virtualbox.repo
sudo dnf -y update
sudo dnf -y install binutils qt gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
sudo dnf -y install VirtualBox-4.2
title "virtualbox END"

# sudo dnf -y groupinstall "GNOME Desktop"

# exercism config
title "exercism"
wget https://github.com/exercism/cli/releases/download/v3.0.13/exercism-3.0.13-linux-x86_64.tar.gz
tar -xf exercism-linux-64bit.tgz
mkdir -p ~/bin
mv exercism ~/bin
 
exercism configure --token=a8e70d9c-94f4-4ac0-9245-4af5c949e187
title "exercism END"

 #yarn
 title "yarn"
 curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
 sudo yum install yarn
 title "yarn-END"
  
 #brave browser
 title "brave"
 sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
 sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
 sudo dnf install brave-browser
 title "brave-END"
   
 #tile screen manager 
 #sudo dnf install i3 i3status dmenu i3lock xbacklight feh conky
 title "tile" 
 git clone https://github.com/gTile/gTile.git ~/.local/share/gnome-shell/extensions/gTile@vibou
 title "tile-END"

# pdf to kindle converter
# https://www.willus.com/k2pdfopt/download/
# calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin\n

#docker
title "docker"
DOCKER_IS_AVAILABLE="$(docker -v 2>&1 >/dev/null)"
if [[ ${DOCKER_IS_AVAILABLE} == '' ]]; then
    echo -e "${bakgrn}[installed][Docker]${txtrst} already installed ;)" ;
else
	echo -e "${bakcyn}[Docker] Start Install ${txtrst}";
  dnf -y install dnf-plugins-core
  dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  dnf config-manager --set-enabled docker-ce-edge
  dnf config-manager --set-enabled docker-ce-test
  dnf install -y docker-ce
	service docker start
	usermod -aG docker $USER
	chkconfig docker on
	echo -e "${bakgrn}[Docker] Finish Install ${txtrst}";
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