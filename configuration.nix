{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];



  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.variables.EDITOR = "nano";


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];  

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

 # Exclude unneeded Gnome packages
 environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
]) ++ (with pkgs; [
  cheese # webcam tool
  gnome-music
  gnome-weather
  gnome-maps
  epiphany # web browser
  geary # email reader
  evince # document viewer
  gnome-characters
  totem # video player
  tali # poker game
  iagno # go game
  hitori # sudoku game
  atomix # puzzle game
]);

 # Enable CUPS to print documents.
 services.printing.enable = true;
 services.printing.drivers = [ 
	
	pkgs.gutenprint # — Drivers for many different printers from many different vendors.
	pkgs.cnijfilter2 # — Drivers for some Canon Pixma devices (Proprietary driver)
	
	]; 

 #  Enable sound with pipewire.
# sound.enable = lib.mkForce false;
 #hardware.pulseaudio.enable = false;
 #security.rtkit.enable = false;
 #services.pipewire = {
 #   enable = false;
 #   alsa.enable = false;
 #   alsa.support32Bit = false;
 #   pulse.enable = false;
 # };

  users.users.alternex = {
    isNormalUser = true;
    description = "alternex";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

   security.sudo.wheelNeedsPassword = false;  

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "alternex";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Mullvad Service
  services.mullvad-vpn.enable = true;

  # Tailscale Service
  services.tailscale.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow seahorse and appimages to run
  programs.seahorse.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  #----=[ Fonts ]=----#

  fonts.packages = with pkgs; [
    noto-fonts
    ubuntu_font_family
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    fira
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     appimage-run
     bat
     bitwarden
     btop
     calibre
     clamav
     curl
     dconf2nix
     dconf-editor
     distrobox
     eza
     ffmpeg-full
     fuse
     fuse3
     gdu
     gh
     git
     gitui
     glances
     glow
     gnome-extension-manager
     gnomeExtensions.appindicator
     gnomeExtensions.dash-to-dock
     gnome-settings-daemon
     gnome-shell-extensions
     gnome-terminal
     gnome-tweaks
     gparted
     graphviz
     jellyfin-ffmpeg
     keepassxc
     lazygit
     meld
     mullvad
     mullvad-vpn
     nano
     ncdu
     nix-du
     nmap
     os-prober
     procs
     python3
     python311Packages.bpython
     python311Packages.keep
     python311Packages.pip
     python311Packages.virtualenv
     qbittorrent
     qemu
     quickemu
     #quickgui
     rsync
     seahorse
     sigil #epub editor
     smartmontools
     tailscale
     tldr
     tor-browser
     tree
     ventoy
     virt-manager
     vscode
     vscode-extensions.mkhl.direnv
     wget
     yt-dlp
     zerofree

     
  ];

  programs.bash = {
  # PS1 Customization
    promptInit = ''

    PS1="\[\e[93m\]\u\[\e[38;5;214m\]@\[\e[38;5;32m\]\h\[\e[38;5;166m\]:\[\e[38;5;178m\]\w\[\e[0m\]\$ "

    '';
  };



  # Enable virtualbox
#    virtualisation.virtualbox.guest.enable = true;
#    virtualisation.virtualbox.guest.x11 = true;

  system.stateVersion = "23.05";

}
