{ config, pkgs, ... }:

{
  home.username = "alternex";
  home.homeDirectory = "/home/alternex";

  # Set dconf settings
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "loki-odin-devtest";
    userEmail = "loki_odin_devtest@protonmail.com";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder

    # networking tools
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    broot
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    nb
    duf
    du-dust
    fd
    tldr
    stacer
    obsidian
    
    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    copyq
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];


  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    '';
    

    # Bash History Control
    historyControl = [ "ignoredups" "ignorespace" ];   

    shellAliases = {
     s = "sudo poweroff";
     eza = "eza -blah";
     bat = "bat --paging=never";
     exa = "eza -blah";
    
     # Git Aliases
     gs = "git status";
     ga = "git add";
     gc = "git commit -m";
     dot = "cd /home/alternex/.dotfiles/nix_configs";
     dev = "cd /home/alternex/dev";
     # k = "kubectl";
    };
  };

  home.stateVersion = "23.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
