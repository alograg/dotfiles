#!/bin/sh

# Insalacion de requisitos

cd ~

echo "I require being a superuser"
sudo echo "Thanks!"

# Instalaciones y actualizaciones
sudo apt update
sudo atp upgrade
sudo apt install -y \
  git \
  build-essential \
  software-properties-common \
  p7zip-full \
  p7zip-rar \
  fuseiso \
  sshfs \
  libarchive-dev libfuse-dev \
  golang

# Configuracion de respaldo de configuracion
if [ "$(type -t config)" = "" ]; then
  config() {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree="$HOME" $@
  }
fi

if [ ! -d $HOME/.cfg ] ; then
  git clone --depth=1 --bare https://github.com/alograg/dotfiles.git $HOME/.cfg
  mkdir -p .config-backup
  config checkout
  if [ $? = 0 ]; then
    echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | grep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
  fi;
  config checkout
  config config status.showUntrackedFiles no
fi

# Configuracion de git
echo -n -e "Change the user and git mail? (y/\e[4mn\e[0m)"
read -p ": " yn
if [ "$yn" = "y" ]; then
  git config --global user.name "$USER"
  read -p "Enter your git email [$USER@exemple.com]: " correo
  correo=${correo:-"$USER@exemple.com"}
  git config --global user.email "$correo"
fi

# git lfs install

# Instalar ultima versionde NeoVim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo apt install -y ./nvim-linux64.deb
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
rm -f ./nvim-linux64.deb

## Instalar ViRm y plugins
sudo apt install -y vifm
git clone --depth=1 https://github.com/google/fuse-archive.git
cd fuse-archive || exit
sudo make install
cd ..
rm -fR fuse-archive
