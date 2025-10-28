{config, pkgs, ...}:

{
  networking.hostName = "desktop";

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false; 
    nvidiaSettings = true;
  };

  programs = {
    steam.enable = true;
    gamemode.enable = true;
  };
}
