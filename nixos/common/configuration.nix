{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

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

  # X11 settings.
  services.xserver = {
    enable = true;
    # Configure keymap
    xkb = {
      layout = "us,kz";
      variant = ",";
      options = "grp:win_space_toggle";
    };
    displayManager.lightdm.enable = true;
    displayManager.lightdm.greeters.slick.enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
          dmenu # common for i3
          i3status
          i3lock
      ];
      extraSessionCommands = ''
${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --primary --auto --output HDMI-0 --left-of DP-0 --auto
      '';
    };
  };

  services.picom = {
   enable = true;
   fade = true;
   inactiveOpacity = 0.9;
   settings = {
     corner-radius = 20;
     blur-method = "dual_kawase";
     blur-strength = 5;
   };
   shadow = true;
   backend = "glx";
  }; 

  # Services
  services.printing.enable = true;
  services.openssh.enable = true;
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.bex = {
    isNormalUser = true;
    description = "bex";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Fonts & Programs
  fonts.packages = with pkgs; [
    inter
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.hasklug
  ];
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    nemo
    feh
    alacritty
    wget
    git
    vlc
    krita
    htop
    libreoffice-qt
    pciutils
    telegram-desktop
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH  
    stdenv.cc.cc.lib
    python313
    ripgrep
    lua5_1
    luarocks
    lua-language-server
    neovim
    nixd
    opencode
    xclip
    harper
    baobab
    i3status-rust
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3000 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
