{ stdenv, fetchurl }:

let

  pname = "codex";
  version = "0.145.0";

in

stdenv.mkDerivation rec {
  inherit pname version;
  src = fetchurl {
    url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "sha256-v68Tybo08q12TkqRbEnPcXeuujKc8PcZ4iJ1ZvyNZio=";
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin

    tar -xzf $src -C $out/bin
    mv $out/bin/codex-x86_64-unknown-linux-musl $out/bin/${pname}
  '';
}
