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
      config = name: system: nixpkgs: {
        configs.${name} = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ({ ... }: { networking.hostName = name; })
            (./configs + "/${name}/configuration.nix")
          ];
        };
      };
    in {
      nixosConfigurations =
        (config "cameron-laptop" "x86_64-linux" nixpkgs-unstable).configs;
    };
}
