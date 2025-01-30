{
  main = rec {
    gateway = "192.168.0.1";
    subnetNumBits = 23;
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    staticIps = {
      media-server = "192.168.1.173";
      anton = "192.168.1.45";
    };
    extraHosts = ''
      ${staticIps.media-server} jellyfin.local
      ${staticIps.media-server} cloud.local
      ${staticIps.anton} anton.local
      ${staticIps.anton} chat.local
    '';
  };
}
