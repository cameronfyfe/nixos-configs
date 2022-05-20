{ pkgs }:

with pkgs;

(vscode-with-extensions.override {
  vscode = vscodium;
  vscodeExtensions = with vscode-extensions; [
    # Language Packs
    bbenoist.nix
    golang.go
    matklad.rust-analyzer
    ms-python.python
    # ms-vscode.cpptools -- BROKEN
    justusadam.language-haskell
    svelte.svelte-vscode
    # File Support
    skellock.just
    tamasfe.even-better-toml
    yzhang.markdown-all-in-one
    # Misc
    editorconfig.editorconfig
  ];
})

