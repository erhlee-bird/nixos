{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];
  services.xserver.desktopManager.xterm.enable = false;

  # Laptop-specific packages (the other ones are installed in `packages.nix`)
  environment.systemPackages = with pkgs; [
    acpi
    git
    jq
    nixfmt
    ripgrep
    tlp
    vim
  ];

  # Install fonts
  fonts = {
    fontconfig = {
      hinting.autohint = true;
      defaultFonts = { emoji = [ "OpenMoji Color" ]; };
    };

    packages = with pkgs; [
      corefonts
      dejavu_fonts
      font-awesome
      freefont_ttf
      google-fonts
      inconsolata
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      openmoji-color
      roboto
      siji
      source-code-pro
      source-sans-pro
      terminus_font
      terminus_font_ttf
    ];
  };

  # Wayland stuff: enable XDG integration, allow sway to use brillo
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      gtkUsePortal = true;
    };
  };

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "ebird" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Boot settings: clean /tmp/, latest kernel and enable bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    tmp.cleanOnBoot = true;
  };

  # Set up locales (timezone and keyboard layout)
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  console.font = "ter-i32b";
  console.packages = with pkgs; [ terminus_font ];

  # Set up user and enable sudo
  users.users.ebird = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "input"
      "lp"
      "networkmanager"
      "plugdev"
      "scanner"
      "storage"
      "vboxusers"
      "video"
      "wheel"
    ];
    shell = pkgs.bash;
  };

  # Set up networking and secure it
  networking = {
    wireless.iwd.enable = true;
    firewall = {
      enable = false;
      allowedTCPPorts = [ 443 80 ];
      allowedUDPPorts = [ 443 80 44857 ];
      allowPing = false;
    };
  };

  # Set environment variables
  environment.variables = {
    NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
    GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
    MOZ_ENABLE_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    ANKI_WAYLAND = "1";
    DISABLE_QT5_COMPAT = "0";
  };

  # Security 
  security = {
    sudo.enable = true;

    # Extra security
    protectKernelImage = true;
  };

  # Sound
  sound = { enable = true; };

  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Do not touch
  system.stateVersion = "20.09";
}
