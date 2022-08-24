{ pkgs, nixpkgs, ... }:

{
  nix = {
    registry.nixpkgs.flake = nixpkgs;
    package = pkgs.nix;
    extraOptions = "experimental-features = nix-command flakes";
    settings.substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    settings.trusted-users = [ "root" "cameron" ];
  };
}