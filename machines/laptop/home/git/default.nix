{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "cameronfyfe";
    userEmail = "cameron.j.fyfe@gmail.com";
    signing = {
      key = "C860BE868EC35DD795FA5F3DA6DDD3816FC14C3F";
      signByDefault = true;
    };
    extraConfig = {
      core = {
        shortlog = "7";
      };
      url."https://github.com/".insteadof = "git://git@github.com/";
    };
  };

  xdg.configFile = {
    "../git/init.json".source = ./init.json;
    "../git/init.sh".source = ./init.sh;
  };
}
