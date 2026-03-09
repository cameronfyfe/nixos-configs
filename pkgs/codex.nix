{ stdenv, fetchurl }:

let

  pname = "codex";
  version = "0.110.0";

in

stdenv.mkDerivation rec {
  inherit pname version;
  src = fetchurl {
    url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
    #105 sha256 = "sha256-eNHDgV1+mNW9QwXtVedOm2RsOHiug0eSGbCu0ow09HM=";
    #106 sha256 = "sha256-FXoZ3DtN/9VfghfjB+BnrNWICDvLkRd8DRKqAojWudI=";
    #107 sha256 = "sha256-nBoWCG6XFXjwwW1Y0H/oKVeRwKWX7rf9Y4j4o/FXnO4=";
    sha256 = "sha256-EkGEP46w79Mgi8zqUjWTio3qRxvp3kr2V2WOkDOcn9w=";
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin

    tar -xzf $src -C $out/bin
    mv $out/bin/codex-x86_64-unknown-linux-musl $out/bin/${pname}
  '';
}
