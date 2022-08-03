{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "cameronfyfe";
    userEmail = "cameron.j.fyfe@gmail.com";
  };

  xdg.configFile = {
    "../git/init.json".source = ./init.json;
    "../git/init.sh".source = ./init.sh;
  };
}
