# nixos-configs

primary: [github:cameronfyfe/nixos-configs](https://github.com/cameronfyfe/nixos-configs)  
mirror: [gitlab:cameronfyfe/nixos-configs](https://gitlab.com/cameronfyfe/nixos-configs)

# Quick start

Build nixos config for current system:

    just build

Build specific nixos config:

    just build cameron-laptop
    just build server

Update nixpkgs in flake lock:

    just update

Deploy to current system:

    just deploy

Deploy to new system with different hostname:

    ./bootstrap.sh <target_hostname>
    git restore flake.nix
    just deploy
