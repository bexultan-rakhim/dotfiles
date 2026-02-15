{ pkgs, ... }:

{
  home.username = "bex";
  home.homeDirectory = "/home/bex";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.packages = with pkgs; [
    alacritty
    bat
    feh
    harper
    htop
    lua5_1
    luarocks
    lua-language-server
    neovim
    python313
    ripgrep
    ranger
  ];

  programs.bash = { # or replace with bash if you use bash
    enable = true;
    shellAliases = {
      hm-edit = "nvim ~/.config/home-manager/home.nix"; # help of use
      hm-switch = "home-manager switch --flake ~/.config/home-manager#bex";
    };
  };

  home.file.".config/bluedevilglobalrc".text = ''
    [Adapters]
    00:1B:DC:F4:76:69_powered=true

    [Devices]
    connectedDevices=
  '';

  xsession.windowManager.i3.config = {
    terminal = "alacritty";
    keybindings = let
      modifier = "Mod1";
    in pkgs.lib.mkOptionDefault {
      "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
    };
  };
}
