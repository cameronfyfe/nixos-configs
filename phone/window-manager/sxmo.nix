{ ... }:

{
  services.xserver.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  services.xserver.windowManager.sxmo.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.autoLogin = {
    enable = true;
    user = "noneucat";
  };
  services.xserver.displayManager.defaultSession = "none+sxmo";
}
