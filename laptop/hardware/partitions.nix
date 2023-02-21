{ ... }:

{
  boot.loader.grub = {
    device = "/dev/nvme0n1";
    enable = true;
    version = 2;
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.luksroot.device = "/dev/nvme0n1p3";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a8d180d5-efb5-422b-84ec-a2431f31061f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D064-6692";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/7aed66ab-63be-4673-ba8e-c0f2dc679714"; }];
}
