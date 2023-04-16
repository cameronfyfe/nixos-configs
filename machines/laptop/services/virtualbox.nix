{ ... }:

{
  # TODO: doesn't work
  virtualisation.virtualbox.host.enable = true;

  users.extraGroups.vboxusers.members = [ "cameron" ];
}
