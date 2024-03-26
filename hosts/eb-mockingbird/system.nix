{ config, lib, pkgs, modulesPath, ... }:

{

  environment.systemPackages = with pkgs; [ hyprland ];

  services = {
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };

    xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
        settings = {
          # Session = "hyprland";
          # User = "ebird";
        };
        wayland.enable = true;
      };
    };

  };

}
