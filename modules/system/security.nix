{ config, lib, pkgs, ... }:

{
  security.sudo.enable = true;
  security.protectKernelImage = true;
  # NixOS/nixpkgs #58396
  security.sudo.extraRules = [{
    commands = [
      {
        command = ''/run/current-system/sw/bin/reboot now ""'';
        options = [ "NOPASSWD" "SETENV" ];
      }
      {
        command = ''/run/current-system/sw/bin/shutdown now ""'';
        options = [ "NOPASSWD" "SETENV" ];
      }
      {
        command = ''/run/current-system/sw/bin/tomb close all ""'';
        options = [ "NOPASSWD" "SETENV" ];
      }
      {
        command = ''/run/current-system/sw/bin/tomb slam ""'';
        options = [ "NOPASSWD" "SETENV" ];
      }
      {
        command = "${pkgs.wireguard-tools}/bin/.wg-quick-wrapped";
        options = [ "NOPASSWD" "SETENV" ];
      }
      {
        command = "/run/current-system/sw/bin/wg-quick";
        options = [ "NOPASSWD" "SETENV" ];
      }
    ];
    groups = [ "wheel" ];
    runAs = "root";
  }];
}
