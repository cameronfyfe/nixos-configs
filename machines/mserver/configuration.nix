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
  networking.firewall.allowedTCPPorts = [ 80 81 443 3579 4000 7878 8080 8090 8096 8686 8989 9117 5000 5001 5500 ];

  # Enable mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    reflector = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  systemd.services.mdns-cname-publisher = {
    description = "mDNS CNAME Publisher";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network.target"
      "avahi-daemon.service"
    ];
    requires = [ "avahi-daemon.service" ];
    serviceConfig = {
      Type = "simple";
      User = "root";
      ExecStart = pkgs.writeShellScript "mdns-cname-publisher" ''
        IP_ADDRESS=$(${pkgs.iproute2}/bin/ip addr show wlp1s0 | ${pkgs.gnugrep}/bin/grep 'inet ' | ${pkgs.gnused}/bin/sed -E 's/inet ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\/.*/\1/' | ${pkgs.gnused}/bin/sed 's/^ *//;s/ *$//')

        function _term {
          pkill -P $$
        }
        trap _term SIGTERM

        ${pkgs.avahi}/bin/avahi-publish --address nextcloud.local --no-reverse $IP_ADDRESS &
        ${pkgs.avahi}/bin/avahi-publish --address onlyoffice.local --no-reverse $IP_ADDRESS &
        ${pkgs.avahi}/bin/avahi-publish --address jellyfin.local --no-reverse $IP_ADDRESS &

        while true; do sleep 10000; done
      '';
      Restart = "always";
      RestartSec = "10";
    };
  };

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

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = false;

  users.users.cameron = {
    isNormalUser = true;
    description = "Cameron";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
    ];
  };

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

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    # nextcloud internally on port 81
    virtualHosts."${config.services.nextcloud.hostName}".listen = [{
      addr = "0.0.0.0";
      port = 81;
    }];
    # mDNS domains all on port 80
    virtualHosts."nextcloud.local" = {
      listen = [{
        addr = "0.0.0.0";
        port = 80;
      }];
      locations."/" = {
        proxyPass = "http://127.0.0.1:81";
        proxyWebsockets = true;
      };
    };
    virtualHosts."onlyoffice.local" = {
      listen = [{
        addr = "0.0.0.0";
        port = 80;
      }];
      locations."/" = {
        proxyPass = "http://127.0.0.1:4000";
        proxyWebsockets = true;
      };
    };
    virtualHosts."jellyfin.local" = {
      listen = [{
        addr = "0.0.0.0";
        port = 80;
      }];
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
      };
    };
  };

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
      trusted_domains = [ "nextcloud.local" "192.168.1.173" ];
    };
  };

  services.scrutiny = {
    enable = true;
    settings.web.listen.host = "0.0.0.0";
    settings.web.listen.port = 5500;
  };

  system.stateVersion = "24.11";
}
