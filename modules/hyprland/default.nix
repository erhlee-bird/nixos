{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      hyprshade
      pyprland
      swaybg
      sway-contrib.grimshot
      wev
      wl-clipboard
      wofi
    ];

    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.file.".config/hypr/hyprshade.toml".source = ./hyprshade.toml;
    home.file.".config/hypr/pyprland.toml".source = ./pyprland.toml;
    home.file.".config/hypr/shaders/blue-light-filter.glsl".source =
      "${pkgs.hyprshade}/share/hyprshade/shaders/blue-light-filter.glsl";
    home.file.".config/hypr/xdph.conf".source = ./xdph.conf;

    systemd.user.services.fakefullscreen_hook = {
      Unit = {
        Description = "Service to run fakefullscreen_hook.sh for Hyprland.";
        Requires = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "default.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "fakefullscreen_hook.sh" ''
          #!/usr/bin/env bash

          export NIXOS_CONFIG_DIR="$HOME/.config/nixos";
          export PATH="$PATH:/etc/profiles/per-user/$USER/bin";
          exec "$NIXOS_CONFIG_DIR/modules/hyprland/fakefullscreen_hook.sh"
        ''}";
        Restart = "always";
        RestartSec = 5;
      };
    };

    systemd.user.services.pypr = {
      Unit = {
        Description = "Run the pypr daemon to extend Hyprland.";
        Requires = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "default.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "pypr.sh" ''
          #!/usr/bin/env bash

          export PATH="$PATH:/etc/profiles/per-user/$USER/bin";
          exec pypr
        ''}";
        Restart = "always";
        RestartSec = 5;
      };
    };

    systemd.user.services.swaybg = {
      Unit = {
        Description = "Run the swaybg daemon to set the wallpaper.";
        Requires = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "default.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "swaybg.sh" ''
          #!/usr/bin/env bash

          export NIXOS_CONFIG_DIR="$HOME/.config/nixos";
          export PATH="$PATH:/etc/profiles/per-user/$USER/bin";
          exec swaybg -m fill -i "$NIXOS_CONFIG_DIR/images/background.jpg"
        ''}";
        Restart = "always";
        RestartSec = 5;
      };
    };
  };
}
