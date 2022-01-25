{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
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

  xdg.configFile = builtins.foldl'
    (set: file: set // { "../${file}".source = ../home + "/${file}"; }) { } [
      ".bashrc"
      ".xmobarrc"
      ".xmonad/xmonad.hs"
      ".xmonad/xstart.sh"
      ".xscreensaver"
      ".Xresources"
    ];
}
