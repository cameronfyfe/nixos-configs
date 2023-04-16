{ ... }:

{
  users.users.cameron = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEL+i3RGjREmTeu43L5s8jycLfzqjZYAuT1m66eSwKrW cameron@cameron-laptop"
    ];
  };
}
