{ device-config, ... }:

# {
#   imports = [ (import (./. + "/${device-config.window-manager}.nix")) ];
# }

{
  imports = [ (import ./phosh.nix) ];
}
