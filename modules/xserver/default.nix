{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.xserver;

in {
  options.modules.xserver = { enable = mkEnableOption "xserver"; };
  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;

        displayManager = {
          autoLogin.enable = true;
          autoLogin.user = "ebird";

          lightdm.enable = true;
        };
      };
    };
  };
}
