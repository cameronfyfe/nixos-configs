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
          tree-sitter-scss
          tree-sitter-svelte
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
      markdown-preview-nvim
      nightfox-nvim
    ];
    coc = {
      enable = true;
      settings = {
        diagnostic.virtualText = true;
        diagnostic.virtualTextCurrentLineOnly = false;
      };
    };
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
        colorscheme carbonfox

        " open with nerdtree for current directory if no cli args
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

        ${disableArrows}

        " default to relative line numbers enabled
        set nu
        set rnu

        " use tab for coc autocompletion (doesn't disable <C-y>)
        inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>" 

        " use <C-j> and <C-k> for scrolling up and down coc auto completions
        " (doesn't disable <C-n> and <C-o>
        inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(0) : "\<C-j>" 
        inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(0) : "\<C-k>" 
      '';
  };
}
