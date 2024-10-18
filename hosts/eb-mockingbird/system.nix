{ config, lib, pkgs, modulesPath, ... }:

{
  environment.etc."wireguard/wg-laptop.conf".source = "/home/ebird/.local/share/wireguard/wg-laptop.conf";
  environment.systemPackages = with pkgs; [
    xfce.xfce4-notifyd
  ];

  nix.settings.trusted-users = [ "@wheel" ];

  programs = {
    hyprland.enable = true;
    uwsm.enable = true;
    uwsm.waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };

  security.pam.services.swaylock.fprintAuth = true;

  services = {
    # Enable this for work.
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        IdleAction=suspend-then-hibernate
        IdleActionSec=2m
      '';
    };

    xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    xserver.desktopManager.runXdgAutostartIfNone = true;
    xserver.enable = true;
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=2h";
  systemd.user.services."wayland-wm-env@" = {
    path = config.services.displayManager.sessionPackages;
    overrideStrategy = "asDropin";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
