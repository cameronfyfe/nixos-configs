{ device-config, ... }:

{
  networking = {
    nameservers = [ "1.1.1.1" "8.8.8.8" ];

    wireless.enable = (device-config.window-manager == "xmonad");

    firewall.allowedTCPPorts = [ 80 8096 ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
