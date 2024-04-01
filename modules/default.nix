{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "21.05";

  # NB: Can we automatically discover all of the sibling `.nix` files?
  imports = [
    # gui
    ./dunst
    ./eww
    ./hyprland
    ./kanshi
    ./swaylock
    ./wofi
    ./work

    # cli
    ./direnv
    ./git
    ./gpg

    # system
    ./packages
    ./xdg
  ];
}
