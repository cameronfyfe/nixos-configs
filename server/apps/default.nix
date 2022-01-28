{ pkgs, ... }:

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
    nixpkgs-fmt
    pkgconfig
    vim
  ];
}
