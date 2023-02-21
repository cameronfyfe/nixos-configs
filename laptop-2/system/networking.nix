{ device-config, ... }:

{
  networking.wireless.enable = (device-config.window-manager == "xmonad");

  networking.nameservers = [ "8.8.8.8" "::1" ];
  networking.resolvconf.enable = false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";

  networking.firewall.allowedTCPPorts = [ 80 443 8000 ];

  # TODO: setup
  #   services.openvpn.servers = {
  #     main = { config = '' config /root/nixos/openvpn/officeVPN.conf ''; };
  #   };
}
