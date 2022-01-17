{ config, pkgs, inputs, ... }:

let

  nixpkgs-config = {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  pkgs-21-11 = import inputs.nixpkgs-21-11 nixpkgs-config;
  pkgs-unstable = import inputs.nixpkgs-unstable nixpkgs-config;
  pkgs-master = import inputs.nixpkgs-master nixpkgs-config;
  pkgs-fork = import inputs.nixpkgs-fork nixpkgs-config;

in {
  imports = [ ./hardware-configuration.nix ./wm ./apps ];

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    package = pkgs.nixUnstable;
    extraOptions = "experimental-features = nix-command flakes";
    trustedUsers = [ "root" "cameron" ];
  };

  nixpkgs.config.allowUnfree = true;

  boot.initrd.luks.devices.luksroot = { device = "/dev/nvme0n1p3"; };
  boot.loader.grub = {
    device = "/dev/nvme0n1";
    enable = true;
    version = 2;
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

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

  fonts.fonts = with pkgs; [ spleen ];

  system.stateVersion = "21.05";
}
