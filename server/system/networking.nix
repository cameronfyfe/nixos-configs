{ ... }:

{
  networking.useDHCP = false; # depreciated (use interface specific options)
  networking.interfaces.enp3s0.useDHCP = true;
}
