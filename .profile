# Add desktopapps to path
if [ -d ~/.local/share/applications ] ; then
  export PATH="~/.local/share/applications:~/.local/share/applications:~/.local/scripts:~/.local/bin:/run/wrappers/bin:/home/alograg/.nix-profile/bin:/nix/profile/bin:/home/alograg/.local/state/nix/profile/bin:/etc/profiles/per-user/alograg/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
fi

