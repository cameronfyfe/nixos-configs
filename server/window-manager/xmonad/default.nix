{ pkgs, ... }:

{
  imports = [ ../../../common/xmonad ];

  environment.systemPackages = [ (pkgs.callPackage ../../../common/xmobar { }) ];

  services.upower.enable = true;
  systemd.services.upower.enable = true;

  services.dbus.enable = true;
  services.dbus.packages = [ pkgs.dconf ];

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.disableWhileTyping = true;

  services.xserver.displayManager.defaultSession = "none+xmonad";

  services.xserver.videoDrivers = [ "modesetting" ];

  services.xserver.xkbOptions = "caps:ctrl_modifier";
}
