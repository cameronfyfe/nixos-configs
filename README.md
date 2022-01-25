# nixos-configs

primary: [gitlab:cameronfyfe/nixos-configs](https://gitlab.com/cameronfyfe/nixos-configs)

mirror: [github:cameronfyfe/nxios-configs](https://github.com/cameronfyfe/nixos-config)

# Quick start

Build specific config:

    just build cameron-laptop
    just build server`

Build config for current system:

    just build

Update nixpkgs pin:

    just update

Deploy to current system:

    sudo nixos-rebuild switch
