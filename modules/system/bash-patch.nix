{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    environment.binbash = mkOption {
      default = true;
      type = types.bool;
      description = ''
        Include a /bin/bash in the system.
      '';
    };
  };

  config = {
    system.activationScripts.binbash = if config.environment.binbash then ''
      mkdir -m 0755 -p /bin
            ln -fns /run/current-system/sw/bin/bash /bin/bash
    '' else ''
      rm -f /bin/bash
            rmdir -p /bin || true
    '';
  };
}
