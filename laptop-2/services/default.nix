{ pkgs, ... }:

{
  imports = [
    ./cron.nix
    ./docker.nix
    ./ipfs.nix
    ./udev
  ];

  services.udisks2.enable = true;

  services.qemuGuest.enable = true;

  # services.activitywatch.enable = true;

  services.printing.enable = true;
  # services.printing.drivers = []
}
