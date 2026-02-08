{pkgs, plasma-manager, ...}:

{
  imports = [ plasma-manager.homeModules.plasma-manager ];

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

  programs.plasma = {
    enable = true;
    fonts = {
      general = {
	family = "Inter";
      	pointSize = 11;
      };
      toolbar = {
	family = "Inter";
	pointSize = 10;
      };
    };

    workspace.lookAndFeel = "com.github.eliverlara.sweet";
    workspace.iconTheme = "Tela-purple";    
    
    kwin = {
      borderlessMaximizedWindows = true;

      titlebarButtons.right = [
	"keep-above-windows"
	"keep-below-windows"
	"minimize"
	"maximize"
	"close"
      ];
      effects = {
        blur = {
	  enable = true;
	  noiseStrength = 0;
	  strength = 4;
        };
	wobblyWindows.enable = true;
	minimization.animation = "magiclamp";
      };
    };
  };
}
