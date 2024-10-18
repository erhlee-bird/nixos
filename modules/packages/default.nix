{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;
in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.enableNixpkgsReleaseCheck = false;
    home.packages = with pkgs; [
      # System utilities.
      devenv
      emacs
      entr
      ffmpeg
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
      tree
      unzip
      vim
      whisper
      xdg-utils
      yadm
      yubikey-manager
      zip

      # Language Servers.
      bash-language-server
      shellcheck
      yaml-language-server

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
