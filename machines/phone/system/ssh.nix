{ ... }:

{
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
}
