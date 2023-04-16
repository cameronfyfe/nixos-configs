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
      url = "github:samueldr-wip/mobile-nixos-wip/wip/pinephone-pro";
      flake = false;
    };
    home-manager-phone = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs-phone"; };
    };

    # -- nixpkgs forks
    nixpkgs-activitywatch.url = "github:cameronfyfe/nixpkgs/activitywatch";
    nixpkgs-git-repo-manager.url = "github:cameronfyfe/nixpkgs/add-git-repo-manager";
    nixpkgs-scrutiny.url = "github:cameronfyfe/nixpkgs/add-scrutiny";
    nixpkgs-slic3r.url = "github:cameronfyfe/nixpkgs/fix-slic3r";
  };

  outputs = { self, ... } @ inputs:
    let
      forks = {
        inherit (inputs)
          nixpkgs-activitywatch
          nixpkgs-git-repo-manager
          nixpkgs-scrutiny
          nixpkgs-slic3r
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
            ./laptop
            "x86_64-linux"
            nixpkgs
            home-manager
          ]

          # -- Laptop (thinkpad t15)
          [
            "cameron-tp-t15"
            ./laptop-2
            "x86_64-linux"
            nixpkgs
            home-manager
          ]

          # -- Home Server
          [
            "cameron-server"
            ./server
            "x86_64-linux"
            nixpkgs
            home-manager
          ]

          # -- Phone (pinephone pro)
          [
            "cameron-phone"
            ./phone
            "aarch64-linux"
            nixpkgs-phone
            home-manager-phone
          ]

          # -- Phone 2 (pinephone)
          [
            "cameron-pine"
            ./pine
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
