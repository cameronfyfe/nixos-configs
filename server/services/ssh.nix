{ device-keys, ... }:

{
  services.openssh.enable = true;

  users.users.cameron.openssh.authorizedKeys.keys = with device-keys; [
    cameron-tp-p15.ssh-pubkey
    # cameron-tp-t15.ssh-pubkey
  ];
}
