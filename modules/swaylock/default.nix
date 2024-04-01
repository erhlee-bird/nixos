{ inputs, lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.swaylock;
in {
  options.modules.swaylock = { enable = mkEnableOption "swaylock"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swayidle
      swaylock
      swaylock-effects
    ];

    services.swayidle = {
      enable = true;

      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock-effects}/bin/swaylock -defF";
        }
        {
          event = "after-resume";
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          event = "lock";
          command = "${pkgs.swaylock-effects}/bin/hyprctl -defF";
        }
      ];
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock-effects}/bin/swaylock -defF";
        }
        {
          timeout = 900;
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        }
      ];
    };

    systemd.user.services.swaylock = {
      Unit = {
        Description = "Run the swaylock daemon to watch monitor changes.";
        Requires = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "default.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swaylock}/bin/swaylock";
        Restart = "always";
        RestartSec = 5;
      };
    };
  };
}
