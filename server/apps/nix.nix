{ pkgs, nixpkgs, ... }:

{
  nix = {
    registry.nixpkgs.flake = nixpkgs;
    package = pkgs.nix_2_5;
    extraOptions = "experimental-features = nix-command flakes";
    settings.trusted-users = [ "root" "cameron" ];
  };
}
