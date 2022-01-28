{ pkgs, ... }:

{
  imports = [ ./hardware ./system ./users ./services ./apps ];

  boot.kernelPackages = pkgs.linuxPackages_5_16;

  system.stateVersion = "22.11";
}
