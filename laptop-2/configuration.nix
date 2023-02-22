{ pkgs, ... }:

{
  imports = [
    ./hardware
    ./services
    ./window-manager
  ] ++ (map (x: ../laptop + "/${x}") [
    "system"
    "users"
    "services"
    "apps"
    "home"
  ]);

  system.stateVersion = "21.11";

  nixpkgs.overlays = [ ];
}
