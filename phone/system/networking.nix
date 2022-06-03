{ ... }:

{
  #networking.wireless.enable = true;

  # Set dns
  networking.nameservers = [ "8.8.8.8" "::1" ];
  networking.resolvconf.enable = false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
}
