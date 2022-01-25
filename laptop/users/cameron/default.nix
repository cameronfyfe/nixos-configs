{ ... }:

{
  users.users.cameron = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  home-manager.users.cameron = import ./home;
}
