NIX_FILES := `find . -type f -name '*.nix' | tr '\n' ' '`

default:
    @just --list

nixfmt +FLAGS='':
    nixfmt {{FLAGS}} {{NIX_FILES}}

switch:
    sudo nixos-rebuild switch --flake .
