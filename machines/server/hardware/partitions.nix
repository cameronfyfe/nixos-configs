{ pkgs, ... }:

{
  boot.loader.grub = {
    device = "/dev/sda";
    enable = true;
    version = 2;
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  swapDevices = [
    { device = "/dev/disk/by-uuid/d3e3b16c-c82f-46bb-8e66-cbe728539771"; }
  ];

  environment.systemPackages = [ pkgs.mergerfs ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/5506a402-f847-4908-a090-3629a81e091b";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/3530-0F00";
      fsType = "vfat";
    };
    "/drives/data-01" = {
      device = "/dev/disk/by-label/data-01";
      fsType = "ext4";
    };
    "/drives/data-02" = {
      device = "/dev/disk/by-label/data-02";
      fsType = "ext4";
    };
    "/drives/data-03" = {
      device = "/dev/disk/by-label/data-03";
      fsType = "ext4";
    };
    "/drives/parity-A" = {
      device = "/dev/disk/by-label/parity-A";
      fsType = "ext4";
    };
    "/data" = {
      device = "drives/data-*";
      depends = [
        "/drives/data-01"
        "/drives/data-02"
        "/drives/data-03"
        "/drives/parity-A"
      ];
      fsType = "fuse.mergerfs";
      options = [
        "direct_io"
        "defaults"
        "allow_other"
        "minfreespace=50G"
        "fsname=mergerfs"
      ];
    };
  };

  snapraid = {
    enable = true;
    dataDisks = {
      d1 = "/drives/data-01";
      d2 = "/drives/data-02";
      d3 = "/drives/data-03";
    };
    parityFiles = [
      "/drives/parity-A/snapraid.parity"
    ];
    contentFiles = [
      "/var/snapraid.content"
      "/drives/data-01/.snapraid.01.content"
      "/drives/data-02/.snapraid.02.content"
      "/drives/data-03/.snapraid.03.content"
    ];
    exclude = [ "/lost+found/" ];
    sync.interval = "24:00";
  };
}
