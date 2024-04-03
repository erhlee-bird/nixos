{ config, pkgs, ... }:

{
  users.users.ebird = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "input"
      "lp"
      "networkmanager"
      "plugdev"
      "scanner"
      "storage"
      "vboxusers"
      "video"
      "wheel"
    ];
    shell = pkgs.bash;
  };
}
