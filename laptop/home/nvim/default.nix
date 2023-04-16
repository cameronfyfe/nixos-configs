{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nerdtree
      (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          # programming
          tree-sitter-rust
          tree-sitter-haskell
          tree-sitter-typescript
          tree-sitter-python
          tree-sitter-go
          tree-sitter-cpp
          # scripting
          tree-sitter-bash
          tree-sitter-vim
          # markup
          tree-sitter-markdown
          tree-sitter-html
          tree-sitter-yaml
          tree-sitter-latex
          tree-sitter-comment
          tree-sitter-norg
        ]))
      vim-nix
      coc-nvim
      coc-rust-analyzer
      nvim-lspconfig
      rust-tools-nvim
    ];
    extraConfig =
      let
        inherit (pkgs.lib)
          concatStrings
          ;
        disableArrows = concatStrings
          (map
            (direction: ''
              nnoremap <${direction}> :echo "NO ${direction}!!!"<CR>
              vnoremap <${direction}> :<C-u>echo "NO ${direction}!!!"<CR>
              inoremap <${direction}> <C-o>:echo "NO ${direction}!!!"<CR>
            '')
            [ "Left" "Right" "Up" "Down" ]
          );
      in
      ''
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

        ${disableArrows}
      '';
  };
}
