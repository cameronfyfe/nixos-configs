{ ... }:

{
  services.xserver.windowManager.xmonad = {
    enable = true;
    config = builtins.readFile ./Main.hs;
    extraPackages = haskellPackages: [
      (haskellPackages.callCabal2nix "CameronXMonad" ./CameronXMonad { })
    ];
  };
}
