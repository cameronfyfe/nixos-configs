{ pkgs, lib, config, ... }:

{
  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
    ];
  };

  # 2. do not forget to enable jellyfin
  services.jellyfin.enable = true;

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "";

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."localhost" = {
      forceSSL = true;
      sslCertificate = ./selfsigned.crt;
      sslCertificateKey = ./selfsigned.key;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        # proxyWebsockets = true; # needed if you need to use WebSocket
        # extraConfig =
        # required when the target is also TLS server with multiple hosts
        #   "proxy_ssl_server_name on;" +
        # required when the server wants to use HTTP Authentication
        #   "proxy_pass_header Authorization;"
        # ;
      };
    };
  };
}
