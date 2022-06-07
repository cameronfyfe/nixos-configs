{ ... }:

{
  services.geoclue2.enable = true;

  users.users.geoclue.extraGroups = [ "networkmanager" ];
}
