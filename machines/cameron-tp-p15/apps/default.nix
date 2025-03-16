{ system, pkgs, common, forks, lurk-rs, claude-desktop, ... }:

let

  nixLd = pkgs.lib.getLib pkgs.glibc + "/lib/ld-linux-x86-64.so.2";

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

  # pins
  google-chrome = (import forks.nixpkgs-google-chrome {
    inherit system;
    config = {
      allowUnfree = true;
    };
  }).google-chrome;

  signal-desktop = (import forks.nixpkgs-signal-desktop {
    inherit system;
  }).signal-desktop;


  #zoom-us = (import forks.nixpkgs-zoom-us {
  #  inherit system;
  #  config = {
  #    allowUnfree = true;
  #  };
  #}).zoom-us;

  # forks

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
      [
        iat
        # system
        lm_sensors
        pavucontrol
        xscreensaver
      ]
      [
        # networking
        curl
        iw
        inetutils
        nebula
        nmap
        wget
        wirelesstools
      ]
      [
        # p2p
        #iroh
        #sendme
        #dumbpipe
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
        ffmpeg-full
        jq
        gnupg
        gparted
        htop
        lzip
        nixfmt-classic
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
        oh-my-zsh
        unrar
        zip
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
        # opera -- BROKEN
      ]
      [
        # dev-tools
        openssl
        openssl.dev
        pkg-config
        stdenv.cc.cc.lib
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
        clippy
        ghc
        go
        patchelf
        pkg-config
        (python3.withPackages (ps: with ps; [
          requests
          huggingface-hub
        ]))
        just
        lldb
        docker
        docker-compose
        insomnia
        graphviz
        moreutils
        protobuf
      ]
      [
        # image/video
        inkscape
        gimp
        pinta
        vlc
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
        zoom-us
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
      [
        # 3d printing
        #slic3r
        # cura
      ]
      [
        qFlipper
      ]
      [
        kazam
        simplescreenrecorder
        (import forks.nixpkgs-mprime-primenet {
          inherit system;
          config.allowUnfree = true;
        }).mprime-primenet
        rpi-imager
      ]
      [
        yarn
        feh
        # (import forks.nixpkgs-lurk {
        #   inherit system;
        # }).lurk-lang
        # lurk
        tmux
        xorg.xmessage
        lsof
        nginx
        makemkv
        ollama
        kubectl
        azure-cli
        linux-wifi-hotspot

      ]
      [
        ollama

        # (pkgs.writeShellScriptBin "claude-desktop" ''
        #   export NIX_LD=${nixLd}
        #   exec ${claude-desktop.packages.${system}.claude-desktop}/bin/claude-desktop "$@"
        # '')

        # (pkgs.buildFHSEnv {
        #   name = "claude-desktop";
        #   targetPkgs = pkgs: with pkgs; [
        #     glibc
        #     openssl
        #     xorg.libX11
        #     xorg.libXcursor
        #     xorg.libXrandr
        #     libdrm
        #     nodejs_22
        #     python3
        #     (import forks.nixpkgs-uv {
        #       inherit system;
        #     }).uv
        #   ];
        #   runScript = "${claude-desktop.packages.${system}.claude-desktop}/bin/claude-desktop";
        # })

        # (pkgs.buildFHSEnv {
        #   name = "claude-desktop";
        #   targetPkgs = pkgs: with pkgs; [
        #     docker
        #     glibc
        #     openssl
        #     nodejs
        #     (import forks.nixpkgs-uv {
        #       inherit system;
        #     }).uv
        #   ];
        #   runScript = "${claude-desktop.packages.${system}.claude-desktop}/bin/claude-desktop";
        # })

        #claude-desktop.packages.${system}.claude-desktop-with-fhs

        (import forks.nixpkgs-uv {
          inherit system;
        }).uv
      ]
    ]);

  programs.zsh.enable = true;

  programs.steam.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      # "donbcfbmhbcapadipfkeojnmajbakjdc" # ruffle
      "dmkamcknogkgcdfhhbddcghachkejeap" # keplr
      "nkbihfbeogaeaoehlefnkodbefgpgknn" # metamask
      "dlcobpjiigpikoobohmabehhmhfoodbb" # Argent (starknet wallet)
      # "bfnaelmomeimhlpmgjnjophhpkkoljpa" # phantom (solana wallet)
      "digfbfaphojjndkpccljibejjbppifbc" # moesif
      "bigelpnhidcahdkpmbgpllmiibdkllai" # vimeo-downloader
      # "abkfbakhjpmblaarustupfnpgjppbmioombali" # memex
      "hnmcofcmhpllkdkncnofkjdlpieagngg" # json-rpc viewer
      "fjoaledfpmneenckfbpdfhkmimnjocfa" # nordvpn
      "lcbjdhceifofjlpecfpeimnnphbcjgnc" # xBrowserSync
      "fpnmgdkabkmnadcjpehmlllkndpkmiak" # Wayback Machine
      "gjagmgiddbbciopjhllkdnddhcglnemk" # HashPack
    ];
  };

  programs.nix-ld.enable = true;

  programs.gnupg.agent.enable = true;

  virtualisation.virtualbox.host.enable = true;
  nixpkgs.config.virtualbox.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "cameron" ];
}
