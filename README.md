# nixos-configs

primary: [gitlab:cameronfyfe/nixos-configs](https://gitlab.com/cameronfyfe/nixos-configs)  
mirror: [github:cameronfyfe/nxios-configs](https://github.com/cameronfyfe/nixos-config)

# Quick start

Build nixos config for current system:

    just build

Build specific nixos config:

    just build cameron-laptop
    just build server

Update nixpkgs pin:

    just update

Deploy to current system:

    just deploy
