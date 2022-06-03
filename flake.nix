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
    activity-watch.url = "gitlab:cameronfyfe/activity-watch-nix";
  };

  outputs = { self, ... } @ inputs:
    let
      shared = import ./shared;
      config = name: path: system: nixpkgs:
        let
          device-config = (import ./device-configs.nix)."${name}";
        in
        {
          "${name}" = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit nixpkgs device-config shared;
              inherit (inputs) mobile-nixos home-manager activity-watch;
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
        map (foldl' (f: e: f e) config) [

          # -- Laptop (thinkpad t15)
          [ "cameron-laptop" ./laptop "x86_64-linux" inputs.nixpkgs ]

          # -- Home Server
          [ "server" ./server "x86_64-linux" inputs.nixpkgs ]

          # -- Phone (pinephone)
          [ "cameron-phone" ./phone "aarch64-linux" inputs.nixpkgs-phone ]

        ];
    in
    {
      nixosConfigurations = merge configs;
    };
}
