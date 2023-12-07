{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.my_syncthing;
  secrets = import ./secrets.nix;
in
{
  options.services.my_syncthing= {
    enablePublicGui = mkOption {
      type = types.bool;
      default = false;
    };
    guiPort = mkOption {
      type = types.str;
      default = "8383";
    };
    user = mkOption {
      type = types.str;
      default = "syncthing";
    };
    group = mkOption {
      type = types.str;
      default = "syncthing";
    };
    configDir = mkOption {
      type = types.str;
      default = "/var/lib/syncthing/.config/syncthing";
    };
    dataDir = mkOption {
      type = types.str;
      default = "/var/lib/syncthing";
    };
    repoPath = mkOption {
      type = types.str;
    };
  };

  config = {

    networking.firewall = mkIf cfg.enablePublicGui {
      allowedTCPPorts = [ cfg.guiPort ];
    };


    services = {
      syncthing = {
        enable = true;
        openDefaultPorts = true;
        user = cfg.user;
        group = cfg.group;
        configDir = cfg.configDir;
        dataDir = cfg.dataDir;
        guiAddress = mkIf cfg.enablePublicGui "0.0.0.0:${cfg.guiPort}";
        settings = {
          devices = {
            rocksteady = {
              name = "rocksteady";
              id = secrets.syncthingIDrocksteady;
            };
            nixosis = {
              name = "nixosis";
              id = secrets.syncthingIDnixosis;
            };
            innodellix = {
              name = "innodellix";
              id = secrets.syncthingIDinnodellix;
            };
            oneplus = {
              name = "oneplus";
              id = secrets.syncthingIDoneplus;
            };
            oneplusNord = {
              name = "oneplusNord";
              id = secrets.syncthingIDoneplusNord;
            };
          };
          folders = {
            mainrepo = {
              path = cfg.repoPath;
              label = "syncfolder";
              devices = [
                "nixosis"
                "oneplus"
                "oneplusNord"
                "rocksteady"
                "innodellix"
              ];
            };
          };
        };
      };
    };
  };
}
