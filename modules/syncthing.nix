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
        guiAddress = mkIf cfg.enablePublicGui "0.0.0.0:${cfg.guiPort}";
        declarative = {
          devices = {
            innixos = {
              name = "innixos";
              id = secrets.syncthingIDinnixos;
            };
            siktirin = {
              name = "siktirin";
              id = secrets.syncthingIDsiktirin;
            };
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
          };
          folders = {
            mainrepo = {
              path = cfg.repoPath;
              label = "syncfolder";
              devices = [
                "nixosis"
                "oneplus"
                "rocksteady"
                "siktirin"
                "innixos"
                "innodellix"
              ];
            };
          };
        };
      };
    };
  };
}
