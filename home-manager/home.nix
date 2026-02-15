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
    sweet-nova
    tela-icon-theme
  ];

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
