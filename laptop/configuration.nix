{ pkgs, activity-watch, alejandra, ... }:

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

  system.stateVersion = "21.11";

  nixpkgs.overlays = [ alejandra.overlay ] ++ activity-watch.overlays;
}
