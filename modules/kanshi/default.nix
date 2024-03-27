{ inputs, lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.kanshi;
in {
  options.modules.kanshi = { enable = mkEnableOption "kanshi"; };

  # kanshi is my replacement for autorandr in wayland
  config = mkIf cfg.enable {
    home.file.".config/kanshi/config".source = ./kanshi.config;
    home.packages = with pkgs; [ kanshi ];

    systemd.user.services.kanshi = {
      Unit = {
        Description = "Run the kanshi daemon to watch monitor changes.";
      };

      Install = { WantedBy = [ "default.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.kanshi}/bin/kanshi";
      };
    };
  };
}
