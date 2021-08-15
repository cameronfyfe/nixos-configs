{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      layout = "us";
      desktopManager = {
        gnome.enable = true;
      };
    };
  };

  networking.useDHCP = false;
  networking.interfaces.enp0s31f5.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking.networkmanager.enable = true;
}
