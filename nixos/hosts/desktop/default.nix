{config, pkgs, ...}:

{
  networking.hostName = "desktop";
  hardware.graphics = {
    enable = true;
    enable32Bit= true;
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
