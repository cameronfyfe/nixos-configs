{ pkgs }:

with pkgs;

let

  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;

in

(vscode-with-extensions.override {
  vscode = vscodium;
  vscodeExtensions = with vscode-extensions; [
    bbenoist.nix
  ];
})
