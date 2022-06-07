{ pkgs, device-config, ... }:

let
  wm = device-config.window-manager;
in
{
  # -- WiFi
  networking.wireless.enable =
    if wm == "phosh" then false
    else if wm == "xfce" then false
    else true;
}
