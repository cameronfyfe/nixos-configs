{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    plugins = (with pkgs.vimPlugins; [
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
    ]);
    extraConfig =
      let
        inherit (pkgs.lib)
          concatStrings
          ;
        disableArrow = direction: ''
          nnoremap <${direction}> :echo "NO ${direction}!!!"<CR>
          vnoremap <${direction}> :<C-u>echo "NO ${direction}!!!"<CR>
          inoremap <${direction}> <C-o>:echo "NO ${direction}!!!"<CR>
        '';
      in
      ''
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

        ${concatStrings (map disableArrow [ "Left" "Right" "Up" "Down" ])}
      '';
  };
}
