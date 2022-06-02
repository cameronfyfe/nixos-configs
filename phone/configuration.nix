{ mobile-nixos, ... }:

let

  mobile-nixos-config =
    (import "${mobile-nixos}/lib/configuration.nix" {
      device = "pine64-pinephone";
    });

in

{
  imports = [
    mobile-nixos-config
    ./home
    ./system
    ./users
  ];

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  system.stateVersion = "22.11";
}
