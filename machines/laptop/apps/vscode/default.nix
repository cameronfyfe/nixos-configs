{ pkgs }:

with pkgs;

let

  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;

  JuanBlanco.solidity = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "solidity";
      publisher = "JuanBlanco";
      version = "0.0.141";
      sha256 = "sha256-UWdjVY6+TyIRuIxru4+4YGqqI0HUU/8yV8BKNlIRIUQ";
    };
    meta = with lib; {
      license = licenses.mit;
    };
  };

  RemixProject.ethereum-remix = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "ethereum-remix";
      publisher = "RemixProject";
      version = "0.0.12";
      sha256 = "sha256-yIKTIz6yxlB6yJRDMer/JHtDmm2qLSDgtlhIEBDvUPQ=";
    };
    meta = with lib; {
      license = licenses.mit;
    };
  };

in

(vscode-with-extensions.override {
  vscode = vscodium;
  vscodeExtensions = with vscode-extensions; [
    # Language Packs
    bbenoist.nix
    golang.go
    tiehuis.zig
    matklad.rust-analyzer
    ms-python.python
    JuanBlanco.solidity
    # RemixProject.ethereum-remix -- BROKEN
    # ms-vscode.cpptools -- BROKEN
    justusadam.language-haskell
    svelte.svelte-vscode
    # File Support
    skellock.just
    tamasfe.even-better-toml
    yzhang.markdown-all-in-one
    jock.svg
    zxh404.vscode-proto3
    # Misc
    editorconfig.editorconfig
    ms-vscode-remote.remote-ssh
    vscodevim.vim
    # asvetliakov.vscode-neovim
    ms-ceintl.vscode-language-pack-es
  ];
})
