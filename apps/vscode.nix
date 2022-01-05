{ pkgs }:

pkgs.vscode-with-extensions.override {
  vscode = pkgs.vscodium;
  vscodeExtensions = (with pkgs.vscode-extensions; [
    # Language Packs
    bbenoist.Nix
    matklad.rust-analyzer
    ms-python.python
    ms-vscode.cpptools
    justusadam.language-haskell
    # File Support
    tamasfe.even-better-toml
    # Debugger
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "remote-ssh-edit";
      publisher = "ms-vscode-remote";
      version = "0.47.2";
      sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    }
    {
      name = "svelte-vscode";
      publisher = "svelte";
      version = "105.3.0";
      sha256 = "11plqsj3c4dv0xg2d76pxrcn382qr9wbh1lhln2x8mzv840icvwr";
    }
  ];
}
