{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [
    xfce.xfce4-notifyd
  ];

  programs = {
    hyprland.enable = true;
  };

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
          command = "dbus-run-session ${pkgs.hyprland}/bin/Hyprland";
          user = "ebird";
        };
        default_session = initial_session;
      };
    };
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
