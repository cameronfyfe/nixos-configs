{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-phone.url = "github:NixOS/nixpkgs/nixos-unstable";
    mobile-nixos = {
      url = "github:NixOS/mobile-nixos";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    home-manager-phone = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs-phone"; };
    };
    activity-watch.url = "gitlab:cameronfyfe/activity-watch-nix";
  };

  outputs = { self, ... } @ inputs:
    let
      shared = import ./shared;
      config = name: path: system: nixpkgs: home-manager:
        let
          device-config = (import ./device-configs.nix)."${name}";
        in
        {
          "${name}" = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit nixpkgs home-manager device-config shared;
              inherit (inputs) mobile-nixos activity-watch;
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

          # -- Laptop (thinkpad t15)
          [ "cameron-laptop" ./laptop "x86_64-linux" nixpkgs home-manager ]

          # -- Home Server
          [ "server" ./server "x86_64-linux" nixpkgs home-manager ]

          # -- Phone (pinephone)
          [ "cameron-phone" ./phone "aarch64-linux" nixpkgs-phone home-manager-phone ]

        ]);
    in
    {
      nixosConfigurations = merge configs;
    };
}
