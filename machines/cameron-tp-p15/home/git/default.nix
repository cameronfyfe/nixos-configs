{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "cameronfyfe";
    userEmail = "cameron.j.fyfe@gmail.com";
    signing = {
      key = "4EF17ABC5197A958D7770CD4578AC982771CC638";
      signByDefault = true;
    };
    aliases = {
      undo = "reset --soft HEAD~1";
    };
    extraConfig = {
      core = {
        editor = "nvim";
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
