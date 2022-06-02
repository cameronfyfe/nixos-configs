{ ... }:

{
  imports = [
    ./cron.nix
    ./docker.nix
    ./ipfs.nix
  ];

  services.udisks2.enable = true;

  services.qemuGuest.enable = true;
}
