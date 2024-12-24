{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "cameronfyfe";
    userEmail = "cameron.j.fyfe@gmail.com";
    signing = {
      key = "17B9B458A4E007F852380D77050BD47743E0F42F";
      signByDefault = true;
    };
    extraConfig = {
      core = {
        shortlog = "7";
      };
      #url."ssh://git@github.com/".insteadof = "https://github.com/";
    };
  };

  xdg.configFile = {
    "../git/init.json".source = ./init.json;
    "../git/init.sh".source = ./init.sh;
  };
}
