{
  main = {
    gateway = "192.168.0.1";
    subnetNumBits = 23;
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    staticIps = {
      cameron-server = "192.168.0.10";
    };
  };
}
