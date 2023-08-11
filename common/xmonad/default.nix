{ pkgs, ... }:

let

  showCustomXMonadKeys = pkgs.stdenv.mkDerivation (
    let
      keysFile = "customXMonadKeys.hs.part";
    in
    rec {
      name = "showCustomXMonadKeys";
      src = ./.;
      phases = [ "buildPhase" "installPhase" ];
      buildPhase = ''
        sed -n \
          '/customKeys =/,/-- customKeysEnd/p' \
          $src/CameronXMonad/src/CameronXMonad.hs \
        > ${keysFile} \
      '';
      # TODO: make better
      installPhase = ''
        mkdir -p $out
        cp ${keysFile} $out/

        mkdir -p $out/bin
        echo "#!/usr/bin/env bash" > $out/bin/${name}
        echo "less $out/${keysFile}" > $out/bin/${name}
        chmod +x $out/bin/${name}
      '';
    }
  );

in

{
  services.xserver.windowManager.xmonad = {
    enable = true;
    config = builtins.readFile ./Main.hs;
    extraPackages = haskellPackages: [
      (haskellPackages.callCabal2nix "CameronXMonad" ./CameronXMonad { })
    ];
  };

  environment.systemPackages = with pkgs; [
    dmenu
    feh
    showCustomXMonadKeys
  ];
}
