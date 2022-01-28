{ pkgs, ... }:

{
  imports = [
    ./hardware
    ./system
    ./users
    ./window-manager
    ./services
    ./apps
    ./home
  ];

  boot.kernelPackages = pkgs.linuxPackages_5_16;

  system.stateVersion = "21.11";
}
