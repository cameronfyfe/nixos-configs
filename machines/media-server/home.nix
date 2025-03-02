{ home-manager, ... }:

{
  imports = [ home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  
    users.cameron = {

      home.stateVersion = "22.11";

      manual.manpages.enable = false;

      programs.git = {
        enable = true;
        lfs.enable = true;
        userName = "cameronfyfe";
        userEmail = "cameron.j.fyfe@gmail.com";
      };
    };
  };
}
