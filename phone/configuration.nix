{ mobile-nixos, ... }:

let

  mobile-nixos-config =
    (import "${mobile-nixos}/lib/configuration.nix" {
      device = "pine64-pinephonepro";
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
