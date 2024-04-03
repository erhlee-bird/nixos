{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    # Show battery charge of bluetooth devices.
    settings = { General = { Experimental = true; }; };
  };

  hardware.pulseaudio = {
    # Automatically switch audio to the connected bluetooth device.
    extraConfig = ''
      load-module module-bluetooth-discover
      load-module module-switch-on-connect
    '';
    extraModules = [ ];
  };

  services.blueman.enable = true;
}
