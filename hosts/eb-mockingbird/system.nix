{ config, inputs, lib, pkgs, modulesPath, ... }:

{
  # environment.etc."greetd/environments".text =
    # lib.concatMapStrings (session: "uwsm start ${session}\n")
      # config.services.displayManager.sessionData.sessionNames;

  environment.etc."osquery/fleet.pem".source = ./fleet.pem;
  environment.etc."osquery/osquery.flags".source = ./flagfile.txt;
  environment.etc."osquery/secret.txt".source = ./secret.txt;
  environment.etc."wireguard/wg-laptop.conf".source = "/home/ebird/.local/share/wireguard/wg-laptop.conf";

  environment.systemPackages = with pkgs; [
    xfce.xfce4-notifyd
  ];

  nix.settings.trusted-users = [ "@wheel" ];

  programs = {
    hyprland.enable = true;
    hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
    regreet = {
      enable = true;
      cageArgs = [ "-s" "-d" "-m" "last" ];
      theme.package = pkgs.canta-theme;
    };
    uwsm.enable = false;
    uwsm.waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };

  security.pam.services.swaylock = {
    fprintAuth = true;
  };

  services = {
    # Enable this for work.
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };

    greetd.enable = true;

    logind = {
      lidSwitch = "suspend-then-hibernate";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        IdleAction=suspend-then-hibernate
        IdleActionSec=2m
      '';
    };

    xserver.desktopManager.runXdgAutostartIfNone = true;
    # xserver.enable = true;
  };

  # Fix for not being able to switch when systemd unit has newlines.
  # - https://github.com/NixOS/nixpkgs/issues/342642
  system.switch.enableNg = false;

  systemd.services.osquery = {
    enable = true;
    serviceConfig = {
      ExecStart = ''${pkgs.osquery}/bin/osqueryd --flagfile /etc/osquery/osquery.flags'';
      Type = "simple";
    };
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=2h";
  systemd.user.services."wayland-wm-env@" = {
    path = config.services.displayManager.sessionPackages;
    overrideStrategy = "asDropin";
  };

  xdg.portal.enable = true;
  # xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
  xdg.portal.xdgOpenUsePortal = true;
}
