{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
  };

  outputs = inputs:
    with inputs;
    let
      config = name: path: system: nixpkgs: {
        "${name}" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixpkgs home-manager; };
          modules = [
            ({ ... }: { networking.hostName = name; })
            (path + "/configuration.nix")
          ];
        };
      };
      configs = cs:
        with builtins;
        foldl' (set: c: set // foldl' (f: e: f e) config c) { } cs;
    in
    {
      nixosConfigurations = configs [
        [
          "cameron-laptop"
          ./laptop
          "x86_64-linux"
          nixpkgs
        ]
        [
          "server"
          ./server
          "x86_64-linux"
          nixpkgs
        ]
      ];
    };
}
