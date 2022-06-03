{ pkgs, shared, ... }:

{
  imports = [ shared.apps.nix ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with builtins;
    foldl' (a: b: a ++ b) [ ] (with pkgs; [
      [
        # Phone Calls
        calls
        # SMS
        chatty
      ]
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
      [
        firefox
      ]
      [
        #spot
      ]
      (with gnome; [
        gnome-maps
        gnome-terminal
      ])
    ]);
}
