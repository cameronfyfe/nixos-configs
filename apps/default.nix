{ pkgs }:

let

  overrides = { vscode = (import ./vscode.nix) { inherit pkgs; }; };

in with pkgs;
with overrides; [
  # Networking
  wirelesstools
  iw
  dhcp
  ping
  curl
  wget
  # WM
  dmenu
  xmobar
  xscreensaver
  # Utils
  jq
  # Editors
  vim
  vscode
  # Browsers
  google-chrome
  chromium
  firefox
  # Dev Tools
  git
  gnumake
  just
  docker
  docker-compose
  insomnia
  # Media
  spotify
  # Work
  slack
  upwork
]

