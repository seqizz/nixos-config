{ pkgs, config, ... }:
let
  ionicons = pkgs.callPackage ../../modules/packages/ionicons.nix {};
  lineicons = pkgs.callPackage ../../modules/packages/lineicons.nix {};
in
{
  fonts = {
    fontconfig.defaultFonts = {
      emoji = [ "Twitter Color Emoji" ];
    };
    fonts = with pkgs; [
      comic-relief
      corefonts
      font-awesome_4
      font-awesome-ttf
      ionicons
      liberation_ttf
      lineicons
      mplus-outline-fonts
      (nerdfonts.override {
        fonts = [
          "Agave"
          "FiraCode"
          "Inconsolata"
          "JetBrainsMono"
          "LiberationMono"
          "Overpass"
          "SourceCodePro"
          "Ubuntu"
          "UbuntuMono"
        ];
      })
      noto-fonts
      powerline-fonts
      twemoji-color-font
    ];
  };
}
