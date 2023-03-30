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

git clone --bare https://github.com/alograg/dotfiles.git $HOME/.cfg

config() {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree="$HOME" $@
}

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

# Configuracion de git

git config --global user.name "$USER"
read -p "Enter your git email [$USER@exemple.com]: " correo
correo=${correo:-"$USER@exemple.com"}
git config --global user.email "$correo"
git config --global core.editor "nvim"
git config --global color.ui "auto"
git config --global core.filemode false
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
git config --global core.excludesfile ~/.config/.gitignore_global
#git config --global commit.gpgsign true
git config --global merge.defaultToUpstream recursive
git config --global push.default simple
git config --global core.preloadindex true
git config --global core.fscache true
git config --global credential.helper cache

# git lfs install