#!/bin/sh

# Insalacion de requisitos

cd ~

sudo apt install -y \
  git \
  neovim \
  vifm \
  build-essential \
  p7zip-full \
  p7zip-rar \
  fuseiso \
  sshfs \
  libarchive-dev libfuse-dev \
  golang
git clone https://github.com/google/fuse-archive.git
cd fuse-archive || exit
sudo make install
cd ..
rm -fR fuse-archive

# Configuracion de respaldo de configuracion

if [ "$(type -t config)" = "" ]; then
  config() {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree="$HOME" $@
  }
fi

if [ ! -d $HOME/.cfg ] ; then
  git clone --bare https://github.com/alograg/dotfiles.git $HOME/.cfg
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
