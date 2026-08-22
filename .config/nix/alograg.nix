# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://nixos.org and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
  ];

  # --- CONFIGURACIÓN DEL KERNEL Y SISTEMA ---
  boot = {
    kernelParams = [ "nohibernate" ];
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # Corrección para el error de Zygote Sandbox de Chrome y navegadores Chromium
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;

  # --- OPTIMIZACIÓN Y MANTENIMIENTO DEL SISTEMA ---
  nix = {
    settings.auto-optimise-store = true;
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # --- HARDWARE Y ACELERACIÓN GRÁFICA ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # Extra packs para solucionar definitivamente el error 'vaInitialize failed' de Chrome
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # --- REDES ---
  networking = {
    hostName = "alograg-nixos";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = false;
  };

  # --- LOCALIZACIÓN Y ENTORNO ---
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;

  # --- SERVICIOS XORG Y ENTORNO DE ESCRITORIO ---
  services.xserver = {
    enable = true;
    wacom.enable = true;
    windowManager.dwm.enable = true;
    xkb = {
      layout = "latam,fr";
      options = "grp:shift_caps_toggle"; # Limpiado el duplicado
    };
    displayManager = {
      lightdm.enable = true;
      startx.enable = true;
    };
  };

  # --- OVERLAYS (Compilación local de dwm y st) ---
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        src = /home/alograg/.sources/dwm;
      });
    })
    (final: prev: {
      st = prev.st.overrideAttrs (old: {
        src = /home/alograg/.sources/st;
      });
    })
  ];

  # --- SERVICIOS DEL SISTEMA ---
  services.clipmenu.enable = true;
  services.devmon.enable = true;
  services.printing.cups-pdf.enable = true;
  services.upower.enable = true; # Resuelve el aviso de DisplayDevice en Chrome

  security.sudo.wheelNeedsPassword = false;

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  # --- VIRTUALIZACIÓN ---
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      data-root = "/var/lib/docker";
    };
  };

  # --- CONFIGURACIÓN DE USUARIO Y PAQUETES ---
  users.users.alograg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" ];
    hashedPassword = "$y$j9T$Tz1a/Jg9uplohlqI2feNM0$ViNydv62C93etkpd17Cl8rt7nV38G5PWKVMYRh4/AsA";
    packages = with pkgs; [
      google-chrome
      chromium
      vitetris
      pacvim
      nb
      vscode
      translate-shell
      telegram-desktop
      passh
    ];
  };

  environment.systemPackages = with pkgs; [
    clipmenu
    curl
    direnv
    dmenu
    dunst
    feh
    ffmpeg-full
    file
    fuse-archive
    fuseiso
    git
    git-lfs
    glab
    htop-vim
    jq
    libnotify
    moc
    p7zip
    pup
    sqlite
    sshfs
    st
    tree
    unzip
    vifm
    vim
    wget
    xinit
    xrdb
    hardinfo2
  ];

  system.stateVersion = "26.05";
}
