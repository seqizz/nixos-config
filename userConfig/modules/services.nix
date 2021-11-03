{config, pkgs, inputs, ...}:
let
  lock-helper = (import ./scripts.nix {pkgs = pkgs;}).lock-helper;
  auto-rotate = (import ./scripts.nix {pkgs = pkgs;}).auto-rotate;
  secrets = import ./secrets.nix {pkgs=pkgs;};
in
{
  # TODO: check later, https://rycee.gitlab.io/home-manager/options.html#opt-systemd.user.startServices
  # systemd.user.startServices = "sd-switch";

  services = {
    kdeconnect.enable = true;
    playerctld.enable = true;
    udiskie.enable = true;
    network-manager-applet.enable = true;

    redshift = {
      enable = true;
      latitude = "53.551086";
      longitude = "9.993682";
    };

    unclutter = {
      enable = true;
      threshold = 15;
      timeout = 2;
      extraOptions = [ "ignore-scrolling" ];
    };

    # XXX: Not yet on 21.05 channel
    # xidlehook = {
      # enable = true;
      # not-when-fullscreen = true;
      # timers = [
        # {
          # # delay = 250;
          # delay = 30;
          # command = "${lock-helper}/bin/lock-helper start";
          # canceller = "${lock-helper}/bin/lock-helper cancel";
        # }
        # {
          # # delay = 120;
          # delay = 10;
          # command = "${lock-helper}/bin/lock-helper lock";
          # canceller = "${lock-helper}/bin/lock-helper cancel";
        # }
      # ];
    # };
  };

  systemd.user = {
    startServices = true;
    services = {
      baglan = {
        Unit = {
          Description = "My precious proxy";
        };
        Install = {
          WantedBy = [
            "multi-user.target"
            "graphical-session.target"
          ];
        };
        Service = {
          ExecStart = secrets.proxyCommand;
          RestartSec = 10;
          Restart = "always";
        };
      };

      xidlehook = {
        Unit = {
          Description = "My screen locker";
          After = [
            "graphical-session.target"
          ];
        };
        Install = {
          WantedBy = [
            "multi-user.target"
            "graphical-session.target"
          ];
        };
        Service = {
          ExecStart = ''
            ${inputs.nixpkgs_unstable.xidlehook}/bin/xidlehook --not-when-fullscreen --timer 250 '${lock-helper}/bin/lock-helper start' '${lock-helper}/bin/lock-helper cancel' --timer 120 '${lock-helper}/bin/lock-helper lock' '${lock-helper}/bin/lock-helper cancel'
          '';
          RestartSec = 25;
          Restart = "always";
          Environment = "DISPLAY=:0";
          PrivateTmp = "false";
        };
      };

      auto-rotate = {
        Unit = {
          Description = "Automatic screen rotation helper";
          After = [
            "graphical-session.target"
          ];
        };
        Service = {
          ExecStart = "${pkgs.bash}/bin/bash ${auto-rotate}/bin/auto-rotate";
          ExecStop = "${pkgs.psmisc}/bin/killall monitor-sensor";
          RestartSec = 5;
          Restart = "always";
          Environment = "DISPLAY=:0";
          PrivateTmp = "false";
        };
      };
    };
  };
}
