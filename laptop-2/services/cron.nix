{ ... }:

{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0  4  * * SAT      root    nix-collect-garbage"
      "35 *  * * *        root    log=/var/log/du.log date > $log && du -a / | sort -nr | head -40 > $log"
    ];
  };
}
