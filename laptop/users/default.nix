{ home-manager, ... }:

{
  imports = [
    ./cameron
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.cameron = import ./cameron/home;
    }
  ];
}

