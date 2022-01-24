{ pkgs }:

with pkgs;

(vscode-with-extensions.override {
  vscode = vscodium;
  vscodeExtensions = with vscode-extensions; [
    # Language Packs
    bbenoist.nix
    matklad.rust-analyzer
    ms-python.python
    ms-vscode.cpptools
    justusadam.language-haskell
    svelte.svelte-vscode
    # File Support
    tamasfe.even-better-toml
    yzhang.markdown-all-in-one
    # Misc
    editorconfig.editorconfig
  ];
})

