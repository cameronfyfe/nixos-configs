{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "my-dotnet";
  buildInputs = with pkgs; [ dotnet-sdk_5 ];
  phases = [ "unpackPhase" "buildPhase" "installPhase" ];
  unpackPhase = "true";
  buildPhase = "true";
  installPhase = "mkdir $out";
}
