{
  inputs = rec {
    nixpkgs-21-11.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs";
    nixpkgs-fork.url = "github:cameronfyfe/nixpkgs";
  };
  outputs = inputs:
    with inputs;
    let
      config = name: path: system: nixpkgs: {
        "${name}" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixpkgs; };
          modules = [
            ({ ... }: { networking.hostName = name; })
            (path + "/configuration.nix")
          ];
        };
      };
      configs = cs:
        with builtins;
        foldl' (a: b: a // b) { } (map (c: foldl' (f: e: f e) config c) cs);
    in {
      nixosConfigurations = configs [
        [ "nixos" ./nixos "x86_64-linux" nixpkgs-unstable ]
        [ "server" ./server "x86_64-linux" nixpkgs-unstable ]
      ];
    };
}
