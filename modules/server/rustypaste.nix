{ config, pkgs, ...}:
let
  secrets = import ../secrets.nix;
in
{
  # We need the package
  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      rustypaste = pkgs.callPackage ../../modules/packages/rustypaste.nix {};
    };
  };
  environment.systemPackages = with pkgs; [
    rustypaste
  ];

  # Systemd definitions
  systemd.services.rustypaste = {
    enable = true;
    wantedBy = [
      "multi-user.target"
    ];
    description = "Paste service";
    environment = {
      AUTH_TOKEN = secrets.rustypasteToken;
      CONFIG = "/shared/rustypaste/config.toml";
    };
    serviceConfig = {
      User = "nobody";
      Group = "nobody";
      ExecStart = "${pkgs.rustypaste}/bin/rustypaste";
      Restart = "always";
      RestartSec = 30;
      StandardOutput = "syslog";
      WorkingDirectory = "/shared/rustypaste";
    };
  };
}
