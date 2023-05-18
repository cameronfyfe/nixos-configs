{ pkgs, device-config, common, ... }:

{
  imports = map (x: common + "/${x}") [
    "apps/nix.nix"
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with builtins;
    foldl' (a: b: a ++ b) [ ] (with pkgs; [
      [
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
        megapixels
        vlc
      ]
      (if device-config.window-manager == "phosh" then
        (with gnome; [
          gnome-contacts
          gnome-maps
          gnome-terminal
        ]) else [ ])
    ]);

  programs.calls.enable = true;
}
