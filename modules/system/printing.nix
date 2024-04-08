{ config, lib, pkgs, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  services.printing.enable = true;
}
