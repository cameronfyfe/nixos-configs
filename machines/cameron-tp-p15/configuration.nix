{ pkgs, rust-overlay, ... }:

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

  system.stateVersion = "24.11";

  nixpkgs.overlays = [
    rust-overlay.overlays.default
  ];
}
