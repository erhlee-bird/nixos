{ inputs, lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.kanshi;
in {
  options.modules.kanshi = { enable = mkEnableOption "kanshi"; };

  # kanshi is my replacement for autorandr in wayland
  #
  # NB: kanshi is great, but Hyprland insists on doing the monitor configuration
  #     and so the bounce back of having them fight over monitor settings is
  #     jarring. Maybe will revisit this in the future, but, for now, they're
  #     tedious to integrate.
  config = mkIf cfg.enable {
    home.file.".config/kanshi/config".source = ./kanshi.config;
    home.packages = with pkgs; [ kanshi ];

    systemd.user.services.kanshi = {
      Unit = {
        Description = "Run the kanshi daemon to watch monitor changes.";
        Requires = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "default.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.kanshi}/bin/kanshi";
        Restart = "always";
        RestartSec = 5;
      };
    };
  };
}
