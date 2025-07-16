{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.work;
in {
  options.modules.work = { enable = mkEnableOption "work"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # System utilities.
      act
      awscli2
      # azure-cli (broken in unstable 10-17-24)
      cloudflared
      flyctl
      ghidra-bin
      k9s
      kubectl
      kubernetes-helm
      minikube
      vault-bin
      yubikey-manager

      # Applications.
      discord
      slack
      zoom-us
    ];
  };
}
