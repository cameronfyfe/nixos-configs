{
  inputs = {
    # -- x86 machines
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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

    # -- nixpkgs forks
    nixpkgs-activitywatch.url = "github:cameronfyfe/nixpkgs/activitywatch";
    nixpkgs-git-repo-manager.url = "github:cameronfyfe/nixpkgs/add-git-repo-manager";
    nixpkgs-iroh.url = "github:cameronfyfe/nixpkgs/iroh";
    nixpkgs-lurk.url = "github:cameronfyfe/nixpkgs/add-lurk";
    nixpkgs-mprime-primenet.url = "github:cameronfyfe/nixpkgs/mprime-primenet";
    nixpkgs-scrutiny.url = "github:cameronfyfe/nixpkgs/add-scrutiny";
    nixpkgs-sendme.url = "github:cameronfyfe/nixpkgs/add-sendme";

    # -- other flakes
    nix-wallpaper.url = "github:lunik1/nix-wallpaper";
    lurk-rs.url = "github:lurk-lab/lurk-rs?rev=ec87c69eb20524a0e6cef3c6ce3d53edf053a16a";
  };

  outputs = { self, ... } @ inputs:
    let
      forks = {
        inherit (inputs)
          nixpkgs-activitywatch
          nixpkgs-git-repo-manager
          nixpkgs-iroh
          nixpkgs-lurk
          nixpkgs-mprime-primenet
          nixpkgs-scrutiny
          nixpkgs-sendme
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
              inherit (inputs) nix-wallpaper lurk-rs;

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

          # -- Laptop (thinkpad t15)
          [
            "cameron-tp-t15"
            ./machines/laptop-2
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

          # -- Phone (pinephone pro)
          [
            "cameron-phone"
            ./machines/phone
            "aarch64-linux"
            nixpkgs-phone
            home-manager-phone
          ]

          # -- Phone 2 (pinephone)
          [
            "cameron-pine"
            ./machines/pine
            "aarch64-linux"
            nixpkgs-phone
            home-manager-phone
          ]

        ]);
    in
    {
      nixosConfigurations = merge configs;
    };
}
