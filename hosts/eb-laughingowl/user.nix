{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    # gui
    firefox.enable = true;
    foot.enable = true;
    eww.enable = true;
    dunst.enable = true;
    hyprland.enable = true;
    wofi.enable = true;

    # cli
    direnv.enable = true;
    git.enable = true;
    gpg.enable = true;

    # system
    xdg.enable = true;
    packages.enable = true;
  };
}
