{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;
in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.enableNixpkgsReleaseCheck = false;
    home.packages = with pkgs; [
      # System utilities.
      emacs
      entr
      file
      fzf
      git
      git-lfs
      gnupg
      htop
      jq
      libnotify
      parallel
      p7zip
      ripgrep
      tmux
      unzip
      vim
      xdg-utils
      yadm
      yubikey-manager
      zip

      # Applications.
      google-chrome
      kitty
      lowdown
      pavucontrol
      pcmanfm
      playerctl
      pqiv
      python3
      vlc

      # Wayland stuff.
      grim
      slop
      slurp
      wf-recorder
    ];
  };
}
