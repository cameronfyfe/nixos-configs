{ pkgs, ... }:

with pkgs;

let

  networking = [
    curl
    dhcp
    iw
    telnet
    ncat
    wget
    wirelesstools
  ];

  window-manager = [
    dmenu
    xmobar
  ];

  utils = [
    cron
    jq
    htop
    lzip
    nixfmt
    nixpkgs-fmt
    scrot
    unzip
    yq-go
  ];

  editors = [
    (import ./vscode.nix { inherit pkgs; })
  ];

  browsers = [
    google-chrome
    chromium
    firefox
  ];

  dev-tools = [
    binutils.bintools
    cachix
    gnumake
    gcc
    clang
    cmake
    SDL2
    llvmPackages.libclang
    rustc
    cargo
    go
    pkgconfig
    python39
    conda
    just
    lldb
    docker
    docker-compose
    insomnia
    awscli2
  ];

  media = [
    liferea
    nextcloud-client
    spotify
  ];

  work = [
    slack
    upwork
    libreoffice
  ];

  music = [
    musescore
  ];

in
{

  imports = [ ./nix.nix ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = networking ++ window-manager ++ utils ++ editors
    ++ browsers ++ dev-tools ++ media ++ work ++ music;
}
