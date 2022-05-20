{ pkgs, nixpkgs, ... }:

{
  nix = {
    registry.nixpkgs.flake = nixpkgs;
    package = pkgs.nixVersions.nix_2_7;
    extraOptions = "experimental-features = nix-command flakes";
    settings.trusted-users = [ "root" "cameron" ];
  };
}
