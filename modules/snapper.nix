{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.my_snapper;
  escapePath = s:
    (if lib.hasPrefix "/" s then lib.substring 1 (lib.stringLength s) s else s);
in
  {
    options.services.my_snapper = {
      subvolume = mkOption {
        type = types.str;
      };
    };

    config = {
      services.snapper = {
        snapshotInterval = "hourly";
        cleanupInterval = "2h";
        configs.${escapePath cfg.subvolume} = {
          subvolume = cfg.subvolume;
          extraConfig = ''
            TIMELINE_CREATE=yes
            TIMELINE_CLEANUP=yes
            TIMELINE_LIMIT_HOURLY=2
            TIMELINE_LIMIT_DAILY=3
            TIMELINE_LIMIT_WEEKLY=2
            TIMELINE_LIMIT_MONTHLY=2
            TIMELINE_LIMIT_YEARLY=0
          '';
        };
      };
    };
}
