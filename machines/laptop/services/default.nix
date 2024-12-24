{ pkgs, ... }:

{
  imports = [
    ./cron.nix
    ./docker.nix
    ./ipfs.nix
    ./tailscale.nix
    ./udev
  ];

  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    # lxqt.enable = true;
    extraPortals = [
      # pkgs.xdg-desktop-portal-gnome
      # pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-hyprland
      # pkgs.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  services.influxdb = {
    enable = true;
  };

  services.udisks2.enable = true;

  services.qemuGuest.enable = true;

  # services.activitywatch.enable = true;

  services.printing.enable = true;
  # services.printing.drivers = []

  services.jellyfin.enable = true;
}
