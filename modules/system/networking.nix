{ config, pkgs, ... }:

{
  # Set up networking and secure it
  networking = {
    firewall = {
      enable = false;
      allowedTCPPorts = [ 443 80 ];
      allowedUDPPorts = [ 443 80 44857 ];
      allowPing = false;
    };

    wireless.iwd.enable = true;
  };
}
