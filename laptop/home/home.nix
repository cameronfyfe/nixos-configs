{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
  };

  services.xscreensaver = {
    enable = true;
    settings = { lock = true; };
  };

  programs.xmobar = {
    enable = true;
    package = pkgs.xmobar;
    extraConfig = builtins.readFile ./.xmobarrc;
  };

  programs.git = {
    enable = true;
    userName = "cameronfyfe";
    userEmail = "cameron.j.fyfe@gmail.com";
  };

  programs.neovim = {
    enable = true;

    plugins = (with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          tree-sitter-python
          tree-sitter-cpp
          tree-sitter-haskell
          tree-sitter-rust
          tree-sitter-vim
          tree-sitter-html
          tree-sitter-markdown
          tree-sitter-yaml
          tree-sitter-latex
          tree-sitter-comment
          tree-sitter-bash
          tree-sitter-norg
        ]))

      vim-nix
    ]);
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
    ".xmonad/xmonad.hs"
    ".xmonad/xstart.sh"
    ".xscreensaver"
  ];
}
