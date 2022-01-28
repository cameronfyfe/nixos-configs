default:
    @just --list

fmt +flags='':
    nixpkgs-fmt {{flags}} .

build config=`hostname` +flags='':
    nix build {{flags}} \
        .#nixosConfigurations."{{config}}".config.system.build.toplevel

update:
    nix flake lock --update-input nixpkgs
