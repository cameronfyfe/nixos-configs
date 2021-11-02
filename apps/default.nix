{ pkgs }:

let

  overrides = {
    vscode = (import ./vscode.nix) { inherit pkgs; };
    R = (import ./R.nix) { inherit pkgs; };
    python3 = pkgs.python39Full.withPackages (python-packages: with python-packages; [
      doit
      flake8
    ]);
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
  cachix
  git
  gnumake
  gcc
  rustc cargo
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

