# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelParams = ["nohibernate"];
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };


  networking = {
    hostName = "alograg-nixos";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true; # use xkb.options in tty.
  };


  # services.xserver.windowManager.dwm =
  #   if builtins.pathExists "/home/alograg/.sources/dwm"
  #   then {
  #     package =  pkgs.dwm.overrideAttrs {
  #       conf = "/home/alograg/.sources/dwm/config.h";
  #       # src = pkgs.fetchFromGitHub {
  #       #         owner = "alograg";
  #       #         repo = "dwm";
  #       #         rev = "refs/tags/v6.4.0-alograg";
  #       #         hash = "";
  #       #       };
  #     };
  #     enable = true;
  #   }
  #   else {
  #     enable = true;
  #   };
 
  services = {
    xserver = {
      enable = true;
      wacom.enable = true;
      windowManager.dwm.enable = true;
      xkb = {
        layout = "latam,fr";
        options = "grp:shift_caps_toggle,grp:shift_caps_toggle";
      };
      displayManager = {
        lightdm.enable = true;
        startx.enable = true;
      };
    };
  };

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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alograg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$y$j9T$Tz1a/Jg9uplohlqI2feNM0$ViNydv62C93etkpd17Cl8rt7nV38G5PWKVMYRh4/AsA";
    packages = with pkgs; [
      google-chrome
      vitetris
      pacvim
      nb
      vscode
      translate-shell
      telegram-desktop
      # mdbook
      # iamb
      # litemdview
      # vimpc
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    xorg.xinit
    xorg.xrdb
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.clipmenu.enable = true;
  #services.dunst.enable = true;
  services.devmon.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  security.sudo.wheelNeedsPassword = false;

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  virtualisation.docker = {
    enable = true;
    #rootless = {
    #  enable = true;
    #  setSocketVariable = true;
    #  daemon.settings = {
    #    data-root = "/var/lib/docker";
    #  };
    #};
    daemon.settings = {
      data-root = "/var/lib/docker";
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

