# Build configuraiton.nix using current channel:
#   nixos-rebuild switch
# Build configuraiton.nix using this flake:
#   nixos-rebuild switch --flake /etc/nixos
{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };
  outputs = inputs: {
    nixosConfigs.cameron = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Things in this set are passed to modules and accessible
      # in the top-level arguments (e.g. `{ pkgs, lib, inputs, ... }:`).
      specialArgs = { inherit inputs; };
      nix = { pkgs, ... }:
        nix {
          nix.registry.nixpkgs.flake = inputs.nixpkgs;
          package = pkgs.nixUnstable;
          extraOptions = "experimental-features = nix-command flakes";
          trustedUsers = [ "root" "cameron" ];
        };
      modules = [ nix ./configuration.nix ];
    };
  };
}
