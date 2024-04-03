{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];
  services.xserver.desktopManager.xterm.enable = false;

  environment = {
    binbash = true;

    systemPackages = with pkgs; [
      acpi
      direnv
      file
      git
      jq
      killall
      magic-wormhole
      nixfmt
      ripgrep
      tlp
      vim
      wireguard-tools
    ];
  };

  virtualisation.docker.enable = true;
}
