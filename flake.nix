{
  inputs = rec {
    nixpkgs-21-11.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs";
    nixpkgs-fork.url = "github:cameronfyfe/nixpkgs";
    nixpkgs = nixpkgs-unstable;
  };
  outputs = inputs: {
    nixosConfigurations = {
      "nixos" = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix ];
      };
    };
  };
}
