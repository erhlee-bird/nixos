# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/35a7850a-6f27-4486-a580-d4324656b908";
      preLVM = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [ "acpi_call" "i2c-dev" "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ef262b9d-54c7-408c-a0be-8a3992dd2097";
    fsType = "ext4";
  };

  fileSystems."/nix/store" = {
    device = "/nix/store";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/20FD-C4A3";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/0747bc30-c834-4262-92cc-e1cb9741c799"; }];

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}