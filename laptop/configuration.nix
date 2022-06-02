{ pkgs, activity-watch, ... }:

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

  nixpkgs.overlays = [ ] ++ activity-watch.overlays;
}
