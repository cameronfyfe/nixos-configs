{ pkgs, shared, ... }:

{
  imports = [ shared.apps.nix ];

  environment.systemPackages = with builtins;
    foldl' (a: b: a ++ b) [ ] (with pkgs; [
      [
        # networking
        curl
        dhcp
        iw
        inetutils
        nmap
        wget
        wirelesstools
      ]
      [
        # editors
        vim
      ]
      [
        # utils
        htop
        nixpkgs-fmt
      ]
      [
        # dev-tools
        gnumake
        pkgconfig
        just
      ]
    ]);
}
