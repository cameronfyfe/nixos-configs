{ pkgs, ... }:

# TODO: organize this better, some stuff is here only out of convenience because
# it shoudn't be defined when gnome is set as the window manager instead of xmonad
{
  services.upower.enable = true;
  systemd.services.upower.enable = true;

  services.dbus.enable = true;
  services.dbus.packages = [ pkgs.dconf ];

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.disableWhileTyping = true;

  services.xserver.displayManager.defaultSession = "none+xmonad";

  services.xserver.windowManager.xmonad = {
    enable = true;
    config = builtins.readFile ./Main.hs;
    extraPackages = haskellPackages: [
      (haskellPackages.callCabal2nix "CameronXMonad" ./CameronXMonad { })
    ];
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  environment.systemPackages = with pkgs; [
    dmenu
    ghc
    (callPackage ./xmobar { })
  ];

  services.xserver.xkbOptions = "caps:ctrl_modifier";
}
