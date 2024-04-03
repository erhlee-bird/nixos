{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.work;
in {
  options.modules.work = { enable = mkEnableOption "work"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # System utilities.
      awscli2
      azure-cli
      cloudflared
      flyctl
      ghidra-bin
      vault
      yubikey-manager

      # Applications.
      slack
      zoom-us
    ];
  };
}
