{
  inputs = {
    # -- x86 machines
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    # -- aarch64 mobile machines
    nixpkgs-phone.url = "github:NixOS/nixpkgs/nixos-unstable";
    mobile-nixos = {
      url = "github:wentam/mobile-nixos/ppp-pr";
      flake = false;
    };
    home-manager-phone = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs-phone"; };
    };

    # -- individual pkg pins
    nixpkgs-google-chrome.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-signal-desktop.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-zoom-us.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-nvim.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-uv.url = "github:NixOS/nixpkgs/nixos-unstable";

    # -- nixpkgs forks
    # nixpkgs-activitywatch.url = "github:cameronfyfe/nixpkgs/activitywatch";
    #nixpkgs-git-repo-manager.url = "github:cameronfyfe/nixpkgs/add-git-repo-manager";
    # nixpkgs-lurk.url = "github:cameronfyfe/nixpkgs/add-lurk";
    nixpkgs-mprime-primenet.url = "github:cameronfyfe/nixpkgs/mprime-primenet";
    # nixpkgs-scrutiny.url = "github:cameronfyfe/nixpkgs/add-scrutiny";

    # -- other flakes
    nix-wallpaper.url = "github:lunik1/nix-wallpaper";
    lurk-rs.url = "github:lurk-lab/lurk-rs?rev=ec87c69eb20524a0e6cef3c6ce3d53edf053a16a";
    claude-desktop = {
      url = "github:cameronfyfe/claude-desktop-linux-flake?ref=latest";
      # inputs = { nixpkgs.follows = "nixpkgs"; };
    };
  };

  outputs = { self, ... } @ inputs:
    let
      forks = {
        inherit (inputs)
          # individual pkg pins
          nixpkgs-google-chrome
          nixpkgs-signal-desktop
          nixpkgs-zoom-us
          nixpkgs-nvim
          nixpkgs-uv
          # nixpkgs forks
          nixpkgs-mprime-primenet
          ;
      };
      common = ./common;
      device-keys = import ./device-keys.nix;
      network = import ./network.nix;
      config = name: path: system: nixpkgs: home-manager:
        let
          device-config = (import ./device-configs.nix)."${name}";
        in
        {
          "${name}" = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit system nixpkgs home-manager forks common;
              inherit device-keys device-config network;
              inherit (inputs) mobile-nixos;
              inherit (inputs) nix-wallpaper lurk-rs claude-desktop;
            };
            modules = [
              ({ ... }: { networking.hostName = name; })
              (path + "/configuration.nix")
            ];
          };
        };
      merge = with builtins;
        foldl' (set: x: set // x) { };
      configs = with builtins;
        map (foldl' (f: x: f x) config) (with inputs; [

          # -- Laptop (thinkpad p15)
          [
            "cameron-tp-p15"
            ./machines/laptop
            "x86_64-linux"
            nixpkgs
            home-manager
          ]

          # -- Media Server
          [
            "media-server"
            ./machines/media-server
            "x86_64-linux"
            nixpkgs
            home-manager
          ]

          # -- Remote NAS 1
          [
            "rnas-1"
            ./machines/rnas-1
            "x86_64-linux"
            nixpkgs
            home-manager
          ]

          # -- Remote NAS 2
          [
            "rnas-2"
            ./machines/rnas-2
            "x86_64-linux"
            nixpkgs
            home-manager
          ]

        ]);
    in
    {
      nixosConfigurations = merge configs;
    };
}
