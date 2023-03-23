#!/usr/bin/sh

# Configuracion de alias

curl https://raw.githubusercontent.com/alograg/dotfiles/master/aliases >~/.bash_aliases

# Insalacion de requisitos

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
cd fuse-archive
make install
cd ..
rm fR fuse-archive
