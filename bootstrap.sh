#!/usr/bin/env bash

set -xeu

NEW_HOSTNAME="$1"
CUR_HOSTNAME=$(hostname)

sed -i "s/\"$NEW_HOSTNAME\"/\"$CUR_HOSTNAME\"/g" flake.nix
sed -i "s/\.\"\${name}\"/\.\"$NEW_HOSTNAME\"/g" flake.nix
sed -i "s/hostName = name/hostName = \"$NEW_HOSTNAME\"/g" flake.nix

nix build .\#nixosConfigurations.$CUR_HOSTNAME.config.system.build.toplevel \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
;

nixos-rebuild --use-remote-sudo switch
