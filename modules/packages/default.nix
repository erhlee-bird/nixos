{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.packages;
  screen = pkgs.writeShellScriptBin "screen" "${builtins.readFile ./screen}";
  bandw = pkgs.writeShellScriptBin "bandw" "${builtins.readFile ./bandw}";
  maintenance =
    pkgs.writeShellScriptBin "maintenance" "${builtins.readFile ./maintenance}";

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # System utilities.
      emacs
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
      barrier
      google-chrome
      kitty
      lowdown
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
