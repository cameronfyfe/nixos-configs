{ pkgs, ... }:

{
  users.users.cameron = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
      "ipfs"
      "plugdev"
    ];
  };
}
