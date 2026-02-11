{pkgs, ...}:

{
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
    # This sets the default terminal variable
    terminal = "alacritty";
    
    # This ensures the $mod+Return binding uses it
    keybindings = let
      modifier = "Mod1"; # Your Alt key
    in pkgs.lib.mkOptionDefault {
      "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
    };
  };
}
