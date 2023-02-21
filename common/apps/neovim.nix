{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          nerdtree
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
          coc-nvim
          coc-rust-analyzer
          nvim-lspconfig
          rust-tools-nvim
        ];
      };
      customRC =
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
  };
}
