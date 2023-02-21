{ pkgs, ... }:

{
  imports = [ ./git ./nvim ];

  home.stateVersion = "22.11";

  manual.manpages.enable = false; # TODO: I want this enabled but manual build breaks right now

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
  };

  xresources.properties = {
    "xterm*font" = "-*-fixed-*-r-normal-*-14-*-*-100-*-*-iso8859-*";
    "XTerm*background" = "black";
    "XTerm*foreground" = "white";
    "XTerm*pointerColor" = "white";
    "XTerm*pointerColorBackground" = "black";
    "XTerm*cursorColor" = "white";
    "XTerm*internalBorder" = 3;
    "XTerm*loginShell" = false;
    "XTerm*scrollBar" = true;
    "XTerm*scrollKey" = false;
    "XTerm*saveLines" = 1000;
    "XTerm*multiClickTime" = 250;
    "XTerm*selectToClipboard" = true;
  };

  xdg.configFile = builtins.foldl'
    (set: file: set // { "../${file}".source = ../home + "/${file}"; })
    { } [
    ".bashrc"
    ".xscreensaver"
  ];
}
