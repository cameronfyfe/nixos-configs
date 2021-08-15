{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix (import ./wm) ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    initrd.luks.devices.luksroot = { device = "/dev/nvme0n1p3"; };
    loader.grub = {
      device = "/dev/nvme0n1";
      enable = true;
      version = 2;
      useOSProber = true;
      efiSupport = true;
    };
    loader.efi.canTouchEfiVariables = true;
  };

  time.timeZone = "America/Denver";

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  virtualisation.docker.enable = true;

  users.groups.docker = { };

  users.users.cameron = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  environment.systemPackages = import ./apps { inherit pkgs; };

  system.stateVersion = "21.05"; # Did you read the comment?
}

