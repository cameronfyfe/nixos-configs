{ pkgs, common, ... }:

let

  web-app = name: url:
    let
      web-app-script = pkgs.writeShellScript name ''
        chromium --new-window ${url}
      '';
    in
    pkgs.stdenv.mkDerivation {
      pname = name;
      inherit name;
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/bin
        cp ${web-app-script} $out/bin/
      '';
    };

in

{
  imports = [ common.apps.nix ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-11.5.0"
  ];

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
        # libs
        gtk3-x11
      ]
      [
        # utils
        cron
        ets
        file
        ffmpeg
        jq
        gnupg
        gparted
        htop
        lzip
        nixfmt
        nixpkgs-fmt
        pv
        scrot
        texlive.combined.scheme-full
        unzip
        usbutils
        yq-go
      ]
      [
        # editors
        (pkgs.callPackage ./vscode.nix { })
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
        gnumake
        gcc
        clang
        cmake
        SDL2
        llvmPackages.libclang
        rustc
        rustfmt
        cargo
        ghc
        go
        patchelf
        pkgconfig
        python39
        conda
        just
        lldb
        docker
        docker-compose
        insomnia
        postman
        awscli2
        alejandra
      ]
      [
        # media
        gimp
        libreoffice
        liferea
        nextcloud-client
        spotify
        pinta
        vlc
      ]
      [
        # messaging
        slack
        signal-desktop
      ]
      [
        # work
        upwork
        clockify
        activity-watch.activity-watch
        (web-app "activity-watch" "http://localhost:5600")
      ]
      [
        # music
        musescore
      ]
      [
        # gaming
        dosbox
        steam
      ]
    ]);

  programs.steam.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      "donbcfbmhbcapadipfkeojnmajbakjdc" # ruffle
      "dmkamcknogkgcdfhhbddcghachkejeap" # keplr
      "digfbfaphojjndkpccljibejjbppifbc" # moesif
      "bigelpnhidcahdkpmbgpllmiibdkllai" # vimeo-downloader
    ];
  };

  programs.gnupg.agent.enable = true;
}
