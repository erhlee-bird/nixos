{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;
    sdl2Override = pkgs.SDL2.overrideAttrs (oldAttrs: rec {
      version = "2.28.5";
      src = pkgs.fetchurl {
        url = "https://libsdl.org/release/SDL2-2.28.5.tar.gz";
        sha256 = "332cb37d0be20cb9541739c61f79bae5a477427d79ae85e352089afdaf6666e4";
      };
    });
in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.enableNixpkgsReleaseCheck = false;
    home.packages = with pkgs; [
      # System utilities.
      alsa-utils
      devenv
      emacs
      entr
      envsubst
      ffmpeg
      file
      fzf
      git
      git-lfs
      gnupg
      gum
      htop
      ijq
      jq
      libnotify
      openai-whisper
      # (openai-whisper-cpp.override {
        # SDL2 = sdl2Override;
      # })
      parallel
      piper-tts
      p7zip
      ripgrep
      tmux
      tree
      unzip
      vim
      xdg-utils
      yadm
      yubikey-manager
      zip

      # Language Servers.
      bash-language-server
      shellcheck
      yaml-language-server

      # Applications.
      google-chrome
      kitty
      lowdown
      pavucontrol
      pcmanfm
      playerctl
      pqiv
      python3
      vlc

      # Wayland stuff.
      grim
      slop
      slurp
      steam
      wf-recorder
      ydotool
    ];
    programs.obs-studio = {
      enable = false;
      plugins = with pkgs.obs-studio-plugins; [
        input-overlay
        obs-backgroundremoval
        obs-composite-blur
        obs-pipewire-audio-capture
        wlrobs
      ];
    };
  };
}
