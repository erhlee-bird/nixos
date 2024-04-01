{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    # gui
    dunst.enable = false;
    eww.enable = true;
    hyprland.enable = true;
    kanshi.enable = false;
    swaylock.enable = true;
    wofi.enable = true;
    work.enable = true;

    # cli
    direnv.enable = true;
    git.enable = true;
    gpg.enable = true;

    # system
    packages.enable = true;
    xdg.enable = true;
  };
}
