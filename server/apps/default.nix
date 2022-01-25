{ pkgs, pkgs-pin, ... }:

{
  imports = [ ./nix.nix ];

  environment.systemPackages = with pkgs; [
    cron
    docker
    docker-compose
    git
    htop
    just
    libreoffice
    nixfmt
    pkgs-pin.ping
    pkgconfig
    vim
  ];
}
