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

  # Set dns
  networking.nameservers = [ "8.8.8.8" "::1" ];
  networking.resolvconf.enable = false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";

  # -- Cell
  services.fwupd.enable = true;

  systemd.services.ModemManager.serviceConfig.ExecStart = [
  "" # clear ExecStart from upstream unit file.
  "${pkgs.modemmanager}/sbin/ModemManager --test-quick-suspend-resume"
];
}
