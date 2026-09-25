# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #services.displayManager.sddm.enable = true;

    services.displayManager.sddm = {
    enable = true;
    extraPackages = with pkgs; [
      sddm-astronaut
      sddm-sugar-dark
     ];

    #theme = "sddm-astronaut-theme";
    #settings = {
     # Theme = {
      #  Current = "sddm-astronaut-theme";
      #};
    };
  #};

  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  #program BASH enable


 programs.bash = {
  enable = true;
  interactiveShellInit = ''
  hyfetch
    eval "$(starship init bash)"
    alias ll='ls -la'
    export PATH="$HOME/bin:$PATH"
  '';
  shellAliases = {
    ll = "ls -la";
    la = "ls -A";
  };
};
  # Enable CUPS to print documents.
  services.printing.enable = true;

  #Flatpak Service Enable
  services.flatpak.enable = true;

  #Bluetuth enable
  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
    };
    Policy = {
      AutoEnable = true;
    };
  };
};

  #Program KDEConnect Enable.
   programs.kdeconnect = {
    enable = true;
    #package = pkgs.gnomeExtensions.gsconnect;
  };


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."pritam" = {
    isNormalUser = true;
    description = "Pritam";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # wget
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget															#Download Online
  micro															#Terminal Esey Text Editor
  neovim														#Text Editor
  #gnuchess
  #blender
  # opera														#Chess Game
  firefox-bin													#Firefox Perfect
  xonotic
 # steam-run														#Single Person Shooting Game
  #assaultcube
  #gnome-browser-connector										#Connect gnome With Browser(Firefox)
  #gnomeExtensions.gsconnect										#Connecting Android Mobile With Gnome Desktop
  #gnomeExtensions.blur-my-shell									#Gnome Extention for Blur Effect
  #gnomeExtensions.dash-to-panel									#For Dash To Pannel
  #gnomeExtensions.compiz-windows-effect							#For wabbily Windows
  #gnomeExtensions.coverflow-alt-tab
  hblock							#for Coverflow Windows
  gnome-boxes
  #gnome-mahjongg
  #gnome-chess
  papirus-icon-theme
  spotify
  parabolic
  heimdall
  git
  glava
  starship
  #ventoy-full
  #warp-terminal
  rustc
  rustup-toolchain-install-master
  gnuchess
  rustus
  cargo
  rustfmt
  clippy
  ruby
  bundler
  rustup
  pkgs.android-tools
  adb-sync
  #waydroid
  freetube
  signal-desktop
  wpsoffice
  hyfetch
  honeyfetch
  #neofetch
  anydesk
  #vscode
  vscodium
  #obs-studio
  #amberol
  klavaro
  tuxtype
  krita
  shotcut
  #google-chrome
  #brave
  obs-studio
  appimage-run
  htop
  vlc
 # steam
  #whitesur-icon-theme
  #bibata-cursors
  telegram-desktop
  gimp
  #ventoy
  #gnomeExtensions.gsconnect
  fish
  gparted
  kdePackages.sddm-kcm
  kdePackages.qtstyleplugin-kvantum
  sddm-astronaut
   sddm-sugar-dark
   kdePackages.qtmultimedia
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;


  virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;


  # Nix settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
