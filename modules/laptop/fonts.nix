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
      dina-font
      fira-code
      fira-code-symbols
      font-awesome_4
      font-awesome-ttf
      inconsolata
      ionicons
      liberation_ttf
      lineicons
      mplus-outline-fonts
      noto-fonts
      powerline-fonts
      proggyfonts
      source-code-pro
      twemoji-color-font
      ubuntu_font_family
    ];
  };
}
