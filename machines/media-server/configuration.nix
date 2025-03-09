{ config, pkgs, device-keys, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./home.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.extraOptions = "experimental-features = nix-command flakes";

  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 8080 8090 8096 5000 5001 ];

  time.timeZone = "US/Pacific";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.cameron = {
    isNormalUser = true;
    description = "Cameron";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
    ];
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    tmux
    vscodium
    just
    htop
    makemkv
    nixpkgs-fmt
    yt-dlp
    unzip
    chromium
    b3sum
    smartmontools
  ];

  services.openssh.enable = true;
  users.users.cameron.openssh.authorizedKeys.keys = with device-keys; [
    cameron-tp-p15.ssh-pubkey
  ];

  virtualisation.docker.enable = true;

  services.tailscale.enable = true;

  #services.nginx = {
  #  enable = true;
  #  appendConfig = builtins.readFile ./nginx.conf;
  #};

  services.jellyfin = {
    enable = true;
  };

  environment.etc."nextcloud-admin-pass".text = "awefawefawef";
  fileSystems."/var/lib/nextcloud/data" = {
    device = "/drives/hdd-8tb-1/nextcloud/data";
    fsType = "none";
    options = [ "bind" ];
  };
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "localhost";
    extraAppsEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) calendar memories onlyoffice tasks;
    };
    config.dbtype = "sqlite";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    settings = {
      trusted_domains = [ "192.168.1.173" "media-server.walrus-typhon.ts.net" ];
    };
  };

  system.stateVersion = "24.11";
}
