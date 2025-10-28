{pkgs, plasma-manager, ...}:

{
  imports = [ plasma-manager.homeModules.plasma-manager ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    sweet
    tela-icon-theme
    # kwin-effects-geometry-change
  ];

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

    workspace.lookAndFeel = "Sweet";
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

      #config.Plugins."geometry-changeEnabled" = true;
      
      #compositing = {
#	enable = true;
#	animationSpeed = 2;
#      };
      # tabbox.layout = "thumbnail_grid";
    };
    # breeze.config.Style.Opacity = 50;
  };
}
