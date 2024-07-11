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
      appimage-run
      direnv
      file
      gh
      git
      jq
      killall
      python311Packages.magic-wormhole
      nixfmt-rfc-style
      ripgrep
      tlp
      vim
      wireguard-tools
    ];
  };

  # NB: In directories with a `.envrc` file and a `flake.nix file, populate the
  #     `.envrc` file with `use flake` or `use flake . --impure` to enable
  #     devshells.
  programs.direnv.enable = true;
  programs.nix-ld.enable = true;

  virtualisation.docker.enable = true;
}
