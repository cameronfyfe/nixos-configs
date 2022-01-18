{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system
    ./users
    ./window-manager
    ./services
    ./apps
  ];

  system.stateVersion = "21.05";
}
