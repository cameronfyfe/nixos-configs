{ system, pkgs, common, forks, ... }:

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

  git-repo-manager = (import forks.nixpkgs-git-repo-manager {
    inherit system;
  }).git-repo-manager;

  scrutiny = (import forks.nixpkgs-scrutiny {
    inherit system;
  }).scrutiny;

  _slic3r = (import forks.nixpkgs-slic3r {
    inherit system;
  }).slic3r;

  inherit (import forks.nixpkgs-risczero {
    inherit system;
  }) cargo-risczero;

in

{
  imports = map (x: common + "/${x}") [
    "apps/nix.nix"
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-11.5.0"
  ];

  environment.systemPackages = with builtins;
    foldl' (a: b: a ++ b) [ ] (with pkgs; [
      (
        let
          inherit (import forks.nixpkgs-activitywatch {
            inherit system;
          }) activitywatch;
        in
        [
          activitywatch
        ]
      )
      [
        # system
        lm_sensors
        pavucontrol
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
        kazam
        fontforge-gtk
        xxd
      ]
      [
        # editors
        (pkgs.callPackage ./vscode { })
      ]
      [
        # browsers
        google-chrome
        chromium
        firefox
        opera
        _slic3r
        cura
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
        git-repo-manager
        ghc
        go
        patchelf
        pkg-config
        python39
        just
        lldb
        docker
        docker-compose
        insomnia
        postman
        graphviz
        moreutils
      ]
      [
        # image/video
        inkscape
        gimp
        pinta
        vlc
        yt-dlp
      ]
      [
        # music
        spotify
      ]
      [
        # misc media
        libreoffice
        liferea
        nextcloud-client
      ]
      [
        # apps
        ledger-live-desktop
      ]
      [
        # messaging
        slack
        signal-desktop
        discord
        tdesktop
        element-desktop
      ]
      [
        # work
        # upwork
        # clockify
        # activity-watch
        # (web-app "activity-watch" "http://localhost:5600")
      ]
      [
        # music
        musescore
      ]
      [
        # gaming
        dosbox
        steam
        winePackages.stableFull
        lutris
        jupyter
      ]
      [
        scrutiny

        neo4j-desktop
      ]
      [
        nodejs # TOOD: this is here just for neovim, package a standalone version for neovim to use
      ]
      [
        cachix
      ]
      [
        # terminal fun
        lolcat
        sl
        neofetch
        jp2a
        cmatrix
      ]
      [
        xsel
        trash-cli
      ]
      [
        cargo-risczero
      ]
    ]);

  programs.steam.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      # "donbcfbmhbcapadipfkeojnmajbakjdc" # ruffle
      "dmkamcknogkgcdfhhbddcghachkejeap" # keplr
      "nkbihfbeogaeaoehlefnkodbefgpgknn" # metamask
      "bfnaelmomeimhlpmgjnjophhpkkoljpa" # phantom (solana wallet)
      "digfbfaphojjndkpccljibejjbppifbc" # moesif
      "bigelpnhidcahdkpmbgpllmiibdkllai" # vimeo-downloader
      "abkfbakhjpmblaafnpgjppbmioombali" # memex
      "hnmcofcmhpllkdkncnofkjdlpieagngg" # json-rpc viewer
      "fjoaledfpmneenckfbpdfhkmimnjocfa" # nordvpn
      "lcbjdhceifofjlpecfpeimnnphbcjgnc" # xBrowserSync
    ];
  };

  programs.gnupg.agent.enable = true;
}
