{ config, pkgs, ... }:

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

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

 # Exclude unneeded Gnome packages
 environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
]) ++ (with pkgs.gnome; [
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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "alternex";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget
     curl
     nano
     git
     rsync
     gdu
     ncdu
     btop
     eza
     bat
     gnome.gnome-tweaks
     gnome.gnome-terminal
     gnome-extension-manager
     gnomeExtensions.dash-to-dock
     gnomeExtensions.appindicator
     gnome.gnome-settings-daemon
     gnome.dconf-editor
     zerofree
     vscode
     vscode-extensions.mkhl.direnv
     nix-du
     graphviz
     
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
