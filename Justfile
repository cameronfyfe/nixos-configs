nix-files := `find . -type f -name '*.nix' | tr '\n' ' '`
configs := `nix eval .#nixosConfigurations --apply builtins.attrNames`


default:
    @just --list

nixfmt +flags='':
    nixfmt {{flags}} {{nix-files}}

build config +flags='':
    nix build {{flags}} \
        .#nixosConfigurations."{{config}}".config.system.build.toplevel

build-all:
    @\
    configs=(`echo {{configs}}`); \
    unset configs[0]; \
    unset configs[-1]; \
    for config in ${configs[@]}; do \
        just build $config; \
    done

list-configs:
    @echo '{{configs}}'
