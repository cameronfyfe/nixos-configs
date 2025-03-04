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
  networking.firewall.allowedTCPPorts = [ 80 443 8096 5000 5001 ];

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

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.cameron = {
    isNormalUser = true;
    description = "Cameron";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
    ];
  };

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "cameron";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    tmux
    #git
    vscodium
    just
    htop
    makemkv
    nixpkgs-fmt
    yt-dlp
    unzip
    chromium
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
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "localhost";
    extraAppsEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) calendar tasks onlyoffice;
    };
    config.dbtype = "sqlite";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    settings = {
      trusted_domains = [ "192.168.1.173" "media-server.walrus-typhon.ts.net" ];
    };
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 4 * * * rsync -ah --exclude='lost+found' /data-1/ /data-2"
    ];
  };

  system.stateVersion = "23.05"; # Did you read the comment?

}
