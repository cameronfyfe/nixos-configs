{ pkgs, ... }:

{
  imports = [ ./nix.nix ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    (import ./tree-sitter.nix { inherit pkgs; })
    (import ./vscode.nix { inherit pkgs; })
  ] ++ (with pkgs; [
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
    cron
    jq
    htop
    lzip
    nixfmt
    scrot
    unzip
    yq-go
    # Editors
    vim
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
    # Media
    liferea
    spotify
    # Work
    slack
    upwork
    libreoffice
    # Music
    musescore
  ]);
}
