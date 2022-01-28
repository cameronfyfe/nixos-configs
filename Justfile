default:
    @just --list

fmt +flags='':
    nixpkgs-fmt .

build config=`hostname` +flags='':
    nix build {{flags}} \
        .#nixosConfigurations."{{config}}".config.system.build.toplevel

update:
    nix flake lock --update-input nixpkgs
