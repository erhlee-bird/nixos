{ inputs, lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.eww;
in {
  options.modules.eww = { enable = mkEnableOption "eww"; };

  config = mkIf cfg.enable {
    # eww package
    home.packages = with pkgs; [
      brightnessctl
      eww
      lua
      networkmanager_dmenu
      wireplumber
    ];

    # configuration
    home.file.".config/eww/eww.scss".source = ./eww.scss;
    home.file.".config/eww/eww.yuck".source = ./eww.yuck;

    # scripts
    home.file.".config/eww/scripts/battery.sh" = {
      source = ./scripts/battery.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/brightness.sh" = {
      source = ./scripts/brightness.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/wifi.sh" = {
      source = ./scripts/wifi.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/workspaces.sh" = {
      source = ./scripts/workspaces.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/workspaces.lua" = {
      source = ./scripts/workspaces.lua;
      executable = true;
    };

    systemd.user.services.eww = {
      Unit = {
        Description = "Run the eww daemon.";
        Requires = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "default.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "eww.sh" ''
          #!/usr/bin/env bash

          export PATH="$PATH:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin/";
          export EWW_BASE="eww -c $HOME/.config/eww"
          export EWW_SCRIPTS="$HOME/.config/eww/scripts"

          exec eww daemon -c $HOME/.config/eww --no-daemonize
        ''}";
        Restart = "always";
        RestartSec = 5;
      };
    };
  };
}
