nix-files := `find . -type f -name '*.nix' | tr '\n' ' '`

default:
    @just --list

nixfmt +flags='':
    nixfmt {{flags}} {{nix-files}}

build config=`hostname` +flags='':
    nix build {{flags}} \
        .#nixosConfigurations."{{config}}".config.system.build.toplevel

update:
    nix flake lock --update-input nixpkgs
