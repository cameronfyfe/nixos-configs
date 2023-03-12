{ network, ... }:

let

  inherit (network.main)
    gateway
    subnetNumBits
    nameservers
    staticIps
    ;

in

{
  networking.interfaces.eth0.ipv4.addresses = [
    {
      address = staticIps.cameron-server;
      prefixLength = subnetNumBits;
    }
  ];

  networking.defaultGateway = {
    address = gateway;
  };

  networking.nameservers = nameservers;

  networking.firewall.allowedTCPPorts = [
    22
    8096
    80
    443
  ];
}
