{ pkgs }:

let

  overrides = {
    vscode = (import ./vscode.nix) { inherit pkgs; };
    R = (import ./R.nix) { inherit pkgs; };
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
  # Editors
  vim
  vscode
  # Browsers
  google-chrome
  chromium
  firefox
  # Dev Tools
  cachix
  git
  gnumake
  gcc
  rustc cargo
  python27Full
  python39Full
  R
  just
  lldb
  docker
  docker-compose
  insomnia
  # Media
  liferea
  spotify
  # Work
  slack
  upwork
  libreoffice
]

