{ pkgs }:

pkgs.vscode-with-extensions.override {
  vscode = pkgs.vscodium;
  vscodeExtensions = (with pkgs.vscode-extensions; [
    bbenoist.Nix
    matklad.rust-analyzer
    ms-vscode.cpptools
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "remote-ssh-edit";
      publisher = "ms-vscode-remote";
      version = "0.47.2";
      sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    }
  ];
}
