{ inputs, lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.swaylock;
in {
  options.modules.swaylock = { enable = mkEnableOption "swaylock"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sway-audio-idle-inhibit
      swayidle
      swaylock-effects
    ];

    programs.swaylock = {
      package = pkgs.swaylock-effects;

      settings = {
        ignore-empty-password = false;
        disable-caps-lock-text = true;
        font = "Inconsolata";

        clock = true;
        timestr = "%R";
        datestr = "%a,%e of %B";

        # XXX: How do I get this from the flake params?
        image = "/home/ebird/.config/nixos/images/background.jpg";

        indicator = true;
        indicator-caps-lock = true;
      };
    };

    services.swayidle = {
      enable = true;

      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock-effects}/bin/swaylock -dfF";
        }
        {
          event = "after-resume";
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          event = "lock";
          command = "${pkgs.swaylock-effects}/bin/swaylock -dfF";
        }
      ];
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock-effects}/bin/swaylock -dfF";
        }
        {
          timeout = 900;
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        }
      ];
    };

    systemd.user.services.sway-audio-idle-inhibit = {
      Unit = {
        Description = "Run the sway-audio-idle-inhibit daemon.";
        Requires = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "default.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "sway-audio-idle-inhibit.sh" ''
          #!/usr/bin/env bash

          export PATH="$PATH:/etc/profiles/per-user/$USER/bin";
          exec sway-audio-idle-inhibit
        ''}";
        Restart = "always";
        RestartSec = 5;
      };
    };
  };
}
