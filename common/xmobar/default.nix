{ stdenv
, procps
, ghc
, xmobar
, writeShellScript
}:

let

  start = writeShellScript "xmobar-start" ''
    SCREEN=''${1:-0}
    (${xmobar}/bin/xmobar -x -$SCREEN ${./xmobar.hs} &)
  '';

  stop = writeShellScript "xmobar-stop" ''
    ${procps}/bin/pkill xmobar
  '';

in

stdenv.mkDerivation {
  name = "xmobar-runner";
  phases = [ "installPhase" ];
  buildInputs = [
    ghc
  ];
  installPhase = ''
    mkdir -p $out/bin
    cp ${start} $out/bin/xmobar-start
    cp ${stop} $out/bin/xmobar-stop
  '';
}
