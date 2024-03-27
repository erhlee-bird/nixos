{ config, lib, pkgs, modulesPath, ... }:

{

  environment.systemPackages = with pkgs; [ hyprland ];

  services = {
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };

    greetd = {
      enable = true;
      restart = false;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "ebird";
        };
        default_session = initial_session;
      };
    };

  };
}
