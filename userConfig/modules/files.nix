{ pkgs, ... }:
let
  sync = "/home/gurkan/syncfolder";
  secrets = import ./secrets.nix {pkgs=pkgs;};
  fileAssociations = import ./file-associations.nix;
in
{
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = fileAssociations;
    };
    configFile = {
      "tridactyl/tridactylrc".source = ./config_files/tridactyl/tridactylrc;
      "tridactyl/themes/mytheme.css".source = ./config_files/tridactyl/mytheme.css;
      "mimeapps.list".force = true;

      "Yubico/u2f_keys".text = secrets.yubicoU2FKeys;
      "Yubico/YKPersonalization.conf".source = ./config_files/YKPersonalization.conf;

      "greenclip.toml".source = ./config_files/greenclip.toml;

      "tig/config".source = ./config_files/tig;

      "picom.conf".source = ./config_files/picom.conf;

      "pylintrc".source = ./config_files/pylintrc;

      "extrakto/extrakto.conf".source = ./config_files/extrakto.conf;
    };
  };

  home.file = {
    ".zshnix".source = ./config_files/zsh_nix;

    ".gist".text = secrets.gistSecret;

    ".tarsnap.key".text = secrets.tarsnapKey;

    ".rustypaste/config.toml".text = secrets.rustypasteSecret;

    ".tarsnaprc".source = ./config_files/tarsnaprc;

    ".thunderbird/profiles.ini".source = ./config_files/thunderbird/profiles.ini;
    ".thunderbird/gurkan.default/user.js".source = ./config_files/thunderbird/user.js;
    ".thunderbird/gurkan.default/chrome/userChrome.css".source = ./config_files/thunderbird/userChrome.css;

    ".mozilla/firefox/installs.ini".source = ./config_files/firefox/installs.ini;
    ".mozilla/firefox/profiles.ini".source = ./config_files/firefox/profiles.ini;
    ".mozilla/firefox/gurkan.default/user.js".source = ./config_files/firefox/user.js;
    ".mozilla/firefox/gurkan.default/chrome/userChrome.css".source = ./config_files/firefox/userChrome.css;
    ".mozilla/native-messaging-hosts/tridactyl.json".source = "${pkgs.tridactyl-native}/lib/mozilla/native-messaging-hosts/tridactyl.json";

    ".trc".text = secrets.rubyTwitterSecret;

    ".proxychains/proxychains.conf".source = ./config_files/proxychains.conf;
  };
}
