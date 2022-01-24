{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

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
    };
}
