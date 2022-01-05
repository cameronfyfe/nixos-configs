# Build configuration.nix using current channel:
#   nixos-rebuild switch
# Build configuration.nix using this flake:
#   nixos-rebuild switch --flake /etc/nixos
{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05"; };
  outputs = inputs: {
    nixosConfigurations.nixos = let
      nix = { pkgs, ... }: {
        nix = {
          registry.nixpkgs.flake = inputs.nixpkgs;
          package = pkgs.nixUnstable;
          extraOptions = "experimental-features = nix-command flakes";
          trustedUsers = [ "root" "cameron" ];
        };
      };
    in inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Things in this set are passed to modules and accessible
      # in the top-level arguments (e.g. `{ pkgs, lib, inputs, ... }:`).
      specialArgs = { inherit inputs; };

      modules = [ nix ./configuration.nix ];
    };
  };
}
