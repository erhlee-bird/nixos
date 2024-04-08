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
    NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    XDG_DATA_HOME = "$HOME/.local/share";
    GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
    GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
    MOZ_ENABLE_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    ANKI_WAYLAND = "1";
    DISABLE_QT5_COMPAT = "0";
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  system.stateVersion = "20.09";
}
