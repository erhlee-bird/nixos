{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.work;
in {
  options.work.packages = { enable = mkEnableOption "work"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # System utilities.
      ghidra-bin
      yubikey-manager

      # Applications.
      slack
      zoom-us
    ];
  };
}
