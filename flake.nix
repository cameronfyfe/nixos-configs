{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    with inputs;
    let
      config = name: path: system: nixpkgs:
        let pkgs-pin = import nixpkgs-pin { inherit system; };
        in {
          "${name}" = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit nixpkgs pkgs-pin home-manager; };
            modules = [
              ({ ... }: { networking.hostName = name; })
              (path + "/configuration.nix")
            ];
          };
        };
      configs = cs:
        with builtins;
        foldl' (set: c: set // foldl' (f: e: f e) config c) { } cs;
    in {
      nixosConfigurations = configs [
        [ # :
          "cameron-laptop"
          ./laptop
          "x86_64-linux"
          nixpkgs
        ]
        [ # :
          "server"
          ./server
          "x86_64-linux"
          nixpkgs
        ]
      ];
      packages.x86_64-linux = {
        vbox = nixos-generators.nixosGenerate {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          format = "virtualbox";
        };
      };
    };
}
