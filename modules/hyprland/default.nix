{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      hyprshade
      swaybg
      wl-clipboard
      wofi
    ];

    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.file.".config/hypr/hyprshade.toml".source = ./hyprshade.toml;
    home.file.".config/hypr/shaders/blue-light-filter.glsl".source = "${pkgs.hyprshade}/share/hyprshade/shaders/blue-light-filter.glsl";

    systemd.user.services.hyprshade = {
      Unit = {
        Description = "Run the hyprshade daemon to reduce blue light.";
      };

      Install = { WantedBy = [ "default.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "hyprshade.sh" ''
          #!/usr/bin/env bash

          export PATH="$PATH:/etc/profiles/per-user/$USER/bin";
          exec hyprshade auto
        ''}";
      };
    };
  };
}
