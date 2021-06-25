{ lib, config, ... }:
let
  secrets = import ../secrets.nix;
in
{
  networking.firewall = {
    allowedTCPPorts = [
      5008
      12345
    ];
    allowedUDPPorts = [
      12345
    ];
  };
  services = {
    shadowsocks = {
      enable = true;
      encryptionMethod = "aes-256-cfb";
      password = secrets.shadowsocksSecret;
      port = 5008;
    };
  };
}
