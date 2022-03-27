{ pkgs, ... }:

{
  imports = [ ./nix.nix ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with builtins;
    foldl' (a: b: a ++ b) [ ] (with pkgs; [
      [
        # system
        dpkg
        xscreensaver
      ]
      [
        # networking
        curl
        dhcp
        iw
        inetutils
        nmap
        wget
        wirelesstools
      ]
      [
        # window-manager
        dmenu
        xmobar
      ]
      [
        # libs
        gtk3-x11
      ]
      [
        # utils
        cron
        jq
        htop
        lzip
        nixfmt
        nixpkgs-fmt
        scrot
        texlive.combined.scheme-full
        unzip
        yq-go
      ]
      [
        # editors
        (import ./vscode.nix { inherit pkgs; })
      ]
      [
        # browsers
        google-chrome
        chromium
        firefox
      ]
      [
        # dev-tools
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
        go_1_17
        patchelf
        pkgconfig
        python39
        conda
        just
        lldb
        docker
        docker-compose
        insomnia
        awscli2
      ]
      [
        # media
        gimp
        libreoffice
        liferea
        nextcloud-client
        spotify
      ]
      [
        # messaging
        slack
        signal-desktop
      ]
      [
        # work
        upwork
      ]
      [
        # music
        musescore
      ]
      [
        # gaming
        dosbox
        runelite
        # runescape
        # steam
      ]
    ]);

  programs.steam.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      "donbcfbmhbcapadipfkeojnmajbakjdc" # ruffle
    ];
  };
}
