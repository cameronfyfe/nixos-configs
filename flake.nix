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
      config = name: path: system: nixpkgs: {
        "${name}" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixpkgs shared; inherit (inputs) mobile-nixos home-manager activity-watch; };
          modules = [
            ({ ... }: { networking.hostName = name; })
            (path + "/configuration.nix")
          ];
        };
      };
    in
    {
      nixosConfigurations =
        with builtins;
        foldl' (set: c: set // foldl' (a: b: a b) config c) { } [

          # -- Laptop (thinkpad t15)
          [ "cameron-laptop" ./laptop "x86_64-linux" inputs.nixpkgs ]

          # -- Home Server
          [ "server" ./server "x86_64-linux" inputs.nixpkgs ]

          # -- Phone (pinephone)
          [ "cameron-phone" ./phone "aarch64-linux" inputs.nixpkgs-phone ]

        ];
    };
}
