{ pkgs }:

let

  overrides = {
    vscode = (import ./vscode.nix) { inherit pkgs; };
    R = (import ./R.nix) { inherit pkgs; };
    python3 = (import ./python3.nix) { inherit pkgs; };
    #dotnet = (import ./dotnet.nix) { inherit pkgs; };
    dotnet = pkgs.dotnet-sdk_5;
  };

in with pkgs;
with overrides; [
  # Networking
  wirelesstools
  iw
  dhcp
  ping
  telnet
  curl
  wget
  # WM
  dmenu
  xmobar
  xscreensaver
  # Utils
  jq
  htop
  lzip
  nixfmt
  scrot
  unzip
  yq-go
  # Editors
  vim
  vscode
  # Browsers
  google-chrome
  chromium
  firefox
  # Dev Tools
  binutils.bintools
  cachix
  git
  gnumake
  gcc
  clang
  dotnet
  llvmPackages.libclang
  rustc
  cargo
  pkgconfig
  python27Full
  python3
  conda
  R
  just
  lldb
  docker
  docker-compose
  insomnia
  awscli2
  # Media
  liferea
  spotify
  # Work
  slack
  upwork
  libreoffice
  # Music
  musescore
]

