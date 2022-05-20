{ ... }:

{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 4 * * SAT      root    nix-collect-garbage"
    ];
  };
}
