{ mobile-nixos, nur, ... }:

let

  mobile-nixos-config =
    (import "${mobile-nixos}/lib/configuration.nix" {
      device = "pine64-pinephone";
    });

in

{
  imports = [
    mobile-nixos-config
    ./apps
    ./home
    ./system
    ./users
    ./window-manager
  ];

  system.stateVersion = "22.11";
}
