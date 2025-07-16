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
      dconf
      direnv
      file
      gh
      git
      jq
      killall
      lsof
      python311Packages.magic-wormhole
      nixfmt-rfc-style
      ripgrep
      temurin-bin
      tlp
      vim
      # virt-manager
      # virt-viewer
      wireguard-tools
    ];
  };

  programs.dconf.enable = true;
  # NB: In directories with a `.envrc` file and a `flake.nix file, populate the
  #     `.envrc` file with `use flake` or `use flake . --impure` to enable
  #     devshells.
  programs.direnv.enable = true;
  programs.nix-ld.enable = true;

  virtualisation.docker.enable = true;
  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu = {
  #     package = pkgs.qemu_kvm;
  #     runAsRoot = true;
  #     swtpm.enable = true;
  #     ovmf = {
  #       enable = true;
  #       packages = [(pkgs.OVMF.override {
  #         secureBoot = true;
  #         tpmSupport = true;
  #       }).fd];
  #     };
  #   };
  # };
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
