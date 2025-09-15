default:
    @just --list

fmt +flags='':
    nixpkgs-fmt {{flags}} .

build config=`hostname` +flags='':
    nix build {{flags}} .#nixosConfigurations."{{config}}".config.system.build.toplevel

deploy:
    nixos-rebuild --use-remote-sudo switch

update INPUT='nixpkgs':
    nix flake update {{INPUT}}
