# nixos-configs

NixOS configs for my daily driver laptop and some servers.

# Quick start

Build nixos config for current system (based on `hostname`):

    just build

Build specific nixos config:

    just build cameron-tp-p15
    just build rnas-1

Update nixpkgs in flake lock:

    just update

Deploy to current system:

    just deploy

Deploy to new system with different hostname:

    ./bootstrap.sh <target_hostname>
    git restore flake.nix
    just deploy
