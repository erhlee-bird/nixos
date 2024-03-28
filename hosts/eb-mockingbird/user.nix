{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    # gui
    dunst.enable = true;
    eww.enable = true;
    hyprland.enable = true;
    kanshi.enable = false;
    wofi.enable = true;

    # cli
    direnv.enable = true;
    git.enable = true;
    gpg.enable = true;

    # system
    packages.enable = true;
    xdg.enable = true;
  };
}
