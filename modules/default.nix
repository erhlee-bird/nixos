{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "21.05";
  imports = [
    # gui
    ./eww
    ./dunst
    ./hyprland
    ./xserver
    ./wofi

    # cli
    ./direnv
    ./git
    ./gpg

    # system
    ./packages
    ./xdg
  ];
}
