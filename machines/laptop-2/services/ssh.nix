{ device-keys, ... }:

{
  services.openssh.enable = true;

  users.users.cameron = {
    openssh.authorizedKeys.keys = [
      device-keys.cameron-tp-p15.ssh-pubkey
    ];
  };
}
