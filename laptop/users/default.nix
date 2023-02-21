{ ... }:

{
  users.users.cameron = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "ipfs"
      "plugdev"
    ];
  };
}
