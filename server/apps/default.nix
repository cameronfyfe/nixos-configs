{ pkgs, common, ... }:

{
  imports = map (x: common + "/${x}") [
    "apps/nix.nix"
    "apps/neovim.nix"
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    brave
    google-chrome
    git
    gnumake
    htop
    just
    nixpkgs-fmt
    parted
  ] ++ [
    (pkgs.callPackage ./vscode.nix { })
  ];
}
