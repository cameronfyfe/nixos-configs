{ ... }:

{
  services.gitlab-runner = {
    enable = true;
    concurrent = 1;
    checkInterval = 3;
    sessionServer.sessionTimeout = 3600;
    services.nixos = {
      registrationConfigFile = ./env;
      tagList = "nixos";
    };
  };
}
