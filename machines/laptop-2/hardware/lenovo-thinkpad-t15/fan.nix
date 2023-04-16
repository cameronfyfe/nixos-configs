{ ... }:

{
  services.thinkfan = {
    enable = true;
    levels = [
      [ 0 0 50 ]
      [ "level auto" 48 82 ]
      [ "level full-speed" 76 32767 ]
    ];
  };

  systemd.services.thinkfan.preStart = "
    /run/current-system/sw/bin/modprobe -r thinkpad_acpi && /run/current-system/sw/bin/modprobe thinkpad_acpi
  ";
}
