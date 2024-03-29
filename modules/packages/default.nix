{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;
in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # System utilities.
      emacs
      entr
      fzf
      git
      git-lfs
      gnupg
      htop
      jq
      libnotify
      parallel
      ripgrep
      tmux
      unzip
      vim
      yadm
      yubikey-manager
      zip

      # Applications.
      google-chrome
      kitty
      lowdown
      pavucontrol
      playerctl
      pqiv
      python3

      # Wayland stuff.
      grim
      slop
      slurp
      wf-recorder
    ];
  };
}
