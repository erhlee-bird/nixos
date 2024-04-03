{ config, pkgs, ... }:

{
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
}
