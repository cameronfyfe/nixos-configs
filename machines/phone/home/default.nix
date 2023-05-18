{ home-manager, ... }:

{
  imports = [ home-manager.nixosModules.home-manager ];

  home.stateVersion = "22.11";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cameron = import ./home.nix;
  };
}
