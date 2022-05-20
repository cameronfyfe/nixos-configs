{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    activity-watch.url = "git+ssh://git@gitlab.com/cameronfyfe/activity-watch-nix";
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
      configs = cs:
        with builtins;
        foldl' (set: c: set // foldl' (f: e: f e) config c) { } cs;
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
