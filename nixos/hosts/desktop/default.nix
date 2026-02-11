{config, pkgs, ...}:

{
  networking.hostName = "desktop";
  hardware.graphics = {
    enable = true;
    enable32Bit= true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xrandrHeads = [
    {
      output = "DP-0";
      primary = true;
    }
    {
      output = "HDMI-0";
      monitorConfig = ''Option "LeftOf" "DP-0"'';
    }
  ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false; 
    nvidiaSettings = true;
  };
  hardware.nvidia-container-toolkit.enable = true;

  programs = {
    steam.enable = true;
    gamemode.enable = true;
  };

  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  systemd.services."ssh-proxy" = {
    enable = false;
  };
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };

}
