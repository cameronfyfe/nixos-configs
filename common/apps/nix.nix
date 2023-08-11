{ pkgs, nixpkgs, ... }:

{
  nix = {
    registry.nixpkgs.flake = nixpkgs;
    package = pkgs.nix;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [ "root" "cameron" ];
    };
  };
}
