{ device-config, network, ... }:

{
  networking = {
    inherit (network.main)
      nameservers
      extraHosts
      ;

    wireless.enable = (device-config.window-manager == "xmonad");

    # firewall.allowedTCPPorts = [ 80 443 8000 ];
  };

  # TODO: setup
  #   services.openvpn.servers = {
  #     main = { config = '' config /root/nixos/openvpn/officeVPN.conf ''; };
  #   };
}
