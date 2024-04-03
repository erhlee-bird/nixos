{ config, inputs, pkgs, ... }:

{
  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings.allowed-users = [ "ebird" ];
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  system.autoUpgrade = {
    allowReboot = false;
    dates = "05:00";
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    randomizedDelaySec = "45min";
  };
}
