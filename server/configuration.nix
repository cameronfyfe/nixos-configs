{ pkgs, ... }:

{
  imports = [
    ./hardware
    ./system
    ./users
    ./home
    ./window-manager
    ./services
    ./apps
  ];

  system.stateVersion = "23.05";
}
