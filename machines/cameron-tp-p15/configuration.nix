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

  system.stateVersion = "21.11";

  nixpkgs.overlays = [ ];

  # services.neo4j = {
  #   enable = true;
  #   workerCount = 2;
  #   bolt.tlsLevel = "DISABLED";
  #   https.enable = false;
  #   defaultListenAddress = "0.0.0.0";
  # };
}
