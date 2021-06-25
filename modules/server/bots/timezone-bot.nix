{ config, pkgs, ...}:
{
  systemd.services.bllk-timezone-bot = {
    enable = true;
    wantedBy = [
      "multi-user.target"
    ];
    description = "Timezone bot";
    serviceConfig = {
      ExecStart = let
        python = pkgs.python3.withPackages (ps: with ps; [
          python-telegram-bot
          pytz
          pyowm
          setuptools
        ]);
      in
        "${python.interpreter} /shared/scripts/bllk_timezone_v4.py";
      Restart = "always";
      RestartSec = 30;
      StandardOutput = "syslog";
    };
  };
}
