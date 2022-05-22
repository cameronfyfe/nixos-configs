{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    activity-watch.url = "gitlab:cameronfyfe/activity-watch-nix";
  };

  outputs = { self, ... } @ inputs:
    with inputs;
    let
      config = name: path: system: nixpkgs: {
        "${name}" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixpkgs home-manager activity-watch; };
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
