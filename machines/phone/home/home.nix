{ pkgs, ... }:

{
  home.stateVersion = "22.11";

  home.sessionVariables = {
    EDITOR = "vim";
    GIT_EDITOR = "vim";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "cameronfyfe";
    userEmail = "cameron.j.fyfe@gmail.com";
  };


  xdg.configFile = builtins.foldl'
    (set: file: set // { "../${file}".source = ../home + "/${file}"; })
    { } [
    ".bashrc"
  ];
}
