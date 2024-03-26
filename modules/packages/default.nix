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
      age
      anki-bin
      bandw
      bat
      fzf
      git
      gnupg
      google-chrome
      grim
      htop
      imagemagick
      libnotify
      lowdown
      lua
      maintenance
      mpv
      pass
      pqiv
      python3
      ripgrep
      slop
      slurp
      tealdeer
      tmux
      unzip
      vim
      wf-recorder
      zig
      zk
    ];
  };
}
