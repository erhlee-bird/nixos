{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [ xfce.xfce4-notifyd ];

  programs = { hyprland.enable = true; };

  security.pam.services.swaylock.fprintAuth = true;

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

    logind = {
      lidSwitch = "suspend-then-hibernate";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        IdleAction=suspend-then-hibernate
        IdleActionSec=2m
      '';
    };
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=2h";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
