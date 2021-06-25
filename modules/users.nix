{ config, pkgs, ...}:
{
  security = {
    pam = {
      loginLimits = [
        { domain = "*"; type   = "hard"; item   = "nofile"; value  = "750000"; }
        { domain = "*"; type   = "soft"; item   = "nofile"; value  = "500000"; }
      ];
    };
  };
  users = {
    mutableUsers = false;
    users = {
      root = {
        shell = pkgs.zsh;
      };
    };
  };
}
