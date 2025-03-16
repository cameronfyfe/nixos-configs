{ ... }:

{
  boot.loader.grub = {
    device = "/dev/nvme0n1";
    enable = true;
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-44964270-c661-4a3d-9658-7909800dfa91".device = "/dev/disk/by-uuid/44964270-c661-4a3d-9658-7909800dfa91";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d9af6e79-36d2-442c-b611-675737ead2f1";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4029-8128";
    fsType = "vfat";
  };

  swapDevices = [ ];
}
