{ ... }:

{
  boot.loader.grub = {
    device = "/dev/sda";
    enable = true;
    version = 2;
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.luksroot.device = "/dev/sda3";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/09b50e1a-7da9-4589-9bff-540e5219a5b1";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4708-043A";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/cb83a30b-dea4-44b2-b4f4-df78f60e221d"; }];
}
