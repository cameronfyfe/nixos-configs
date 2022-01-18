{ pkgs, ... }:

# TODO: organize this better, some stuff is here only out of convenience because
# it shoudn't be defined when gnome is set as the window manager instead of xmonad
{
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  systemd.services.upower.enable = true;

  services.dbus.enable = true;
  services.dbus.packages = [ pkgs.dconf ];

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.disableWhileTyping = true;

  services.xserver.displayManager.defaultSession = "none+xmonad";

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  services.xserver.xkbOptions = "caps:ctrl_modifier";

  services.blueman.enable = true;

  networking.wireless.enable = true;
}
