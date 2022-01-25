{ home-manager, ... }:

{
  imports = [ home-manager.nixosModules.home-manager ./cameron ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}

