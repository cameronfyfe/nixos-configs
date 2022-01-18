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

  boot.initrd.luks.devices.luksroot = { device = "/dev/nvme0n1p3"; };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4d3f405b-8710-4fd3-bf7a-bb87e268a2f3";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/566F-3405";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/7fa00ad6-1248-4460-8810-88e093434b45"; }];
}
