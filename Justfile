default:
    @just --list

fmt +flags='':
    nixpkgs-fmt {{flags}} .

build config=`hostname` +flags='':
    nix build {{flags}} .#nixosConfigurations."{{config}}".config.system.build.toplevel

deploy:
    nixos-rebuild --use-remote-sudo switch

update INPUT='nixpkgs':
    nix flake lock --update-input {{INPUT}}

# Bootstrap a configuration onto a new device with a different hostname
# Ex. (bootstrap 'cameron-laptop' config onto new device with default hostname='nixos')
#   just bootstrap-hostname cameron-laptop
#   just deploy
#   git restore flake.nix
#   just deploy
# Done.
bootstrap-hostname newName curName=`hostname`:
    sed -i 's/"{{newName}}"/"{{curName}}"/g' flake.nix
    sed -i 's/\."${name}"/\."{{newName}}"/g' flake.nix
    sed -i 's/hostName = name/hostName = "{{newName}}"/g' flake.nix
