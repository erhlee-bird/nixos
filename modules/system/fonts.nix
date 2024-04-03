{ config, pkgs, inputs, ... }:

{
  console.font = "ter-i32b";
  console.packages = with pkgs; [ terminus_font ];

  # Install fonts
  fonts = {
    enableDefaultPackages = true;

    fontconfig = {
      enable = true;
      defaultFonts.emoji =
        [ "NerdFontsSymbolsOnly" "JoyPixels" "Noto Color Emoji" ];
      hinting.autohint = true;
    };

    fontDir.enable = true;

    packages = with pkgs; [
      font-awesome
      inconsolata
      joypixels
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      noto-fonts
      noto-fonts-color-emoji
      source-code-pro
      source-sans-pro
    ];
  };

  nixpkgs.config.joypixels.acceptLicense = true;
}
