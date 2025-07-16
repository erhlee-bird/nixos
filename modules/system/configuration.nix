{ config, pkgs, inputs, ... }:

{
  imports = [
    ./bash-patch.nix
    ./bluetooth.nix
    ./boot.nix
    ./fonts.nix
    ./networking.nix
    ./packages.nix
    ./printing.nix
    ./security.nix
    ./sound.nix
    ./upgrade.nix
    ./users.nix
  ];

  # Set up locales (timezone and keyboard layout)
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Set environment variables
  environment.variables = {
    ANKI_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    # DISABLE_QT5_COMPAT = "0";
    # GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
    # GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    NIXOS_OZONE_WL = "1";

    # Hyprland-specific.
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  hardware.graphics.enable = true;
  hardware.i2c.enable = true;

  system.stateVersion = "20.09";
}
