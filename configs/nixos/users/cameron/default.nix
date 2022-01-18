{ ... }:

{
  users.users.cameron = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };
}
