{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    # gui
    dunst.enable = true;
    eww.enable = true;
    hyprland.enable = true;
    wofi.enable = true;
    xserver.enable = true;

    # cli
    direnv.enable = true;
    git.enable = true;
    gpg.enable = true;

    # system
    xdg.enable = true;
    packages.enable = true;
  };
}
