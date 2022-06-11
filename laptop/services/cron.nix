{ ... }:

{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0  4  * * SAT      root    nix-collect-garbage"
      "30 *  * * *        root    du -a / | sort -nr | head -40 > /var/log/du.log"
    ];
  };
}
