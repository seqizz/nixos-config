{ config, pkgs, ...}:
let
  writeSubbedBin = (import ../helper-modules/writeSubbedBin.nix {
    pkgs = pkgs;
  }).writeSubbedBin;
  bash = pkgs.bash;
  dnscrypt = pkgs.dnscrypt-proxy2;
  grep = pkgs.gnugrep;
  networkmanager = pkgs.networkmanager;
  dnscrypt-helper = (writeSubbedBin {
    name = "dnscrypt-helper";
    src = ../scripts/dnscrypt-helper;
    inherit bash grep networkmanager dnscrypt;
  });
in
{
  environment.etc."dnscrypt/config.toml".text = ''
    server_names = ['scaleway-fr', 'quad9-dnscrypt-ip4-nofilter-pri', 'dnscrypt.eu-dk']
    listen_addresses = ['127.0.0.1:53', '[::1]:53']
    max_clients = 250
    ipv4_servers = true
    ipv6_servers = false
    dnscrypt_servers = true
    doh_servers = true
    require_dnssec = false
    require_nolog = true
    require_nofilter = true
    force_tcp = false
    timeout = 2500
    keepalive = 30
    cert_refresh_delay = 240
    ignore_system_dns = false
    netprobe_timeout = 30
    log_files_max_size = 10
    log_files_max_age = 7
    log_files_max_backups = 1
    block_ipv6 = false
    cache = true
    cache_size = 512
    cache_min_ttl = 60
    cache_max_ttl = 720
    cache_neg_min_ttl = 5
    cache_neg_max_ttl = 60
    [sources]
      [sources.'public-resolvers']
      urls = ['https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v2/public-resolvers.md', 'https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md']
      cache_file = 'public-resolvers.md'
      minisign_key = 'RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3'
      refresh_delay = 72
  '';

  systemd.services.dnscrypt-proxy = {
    enable = true;
    wantedBy = [
      "multi-user.target"
      "graphical-session.target"
    ];
    description = "dnscrypt service";
    script = "${dnscrypt-helper}/bin/dnscrypt-helper";
    serviceConfig = {
      Restart = "always";
      RestartSec = 30;
    };
  };

  networking.networkmanager = {
    insertNameservers = ["127.0.0.1"];
    dispatcherScripts = [ {
      source = pkgs.writeText "disableDNScryptOnVPN" ''
        #!/usr/bin/env ${pkgs.bash}/bin/bash

        if [[ "$2" == "vpn-up" ]]; then
          logger "VPN connected, disabling dnscrypt-proxy"
          ${pkgs.systemd}/bin/systemctl stop dnscrypt-proxy
        fi
        if [[ "$2" == "vpn-down" ]]; then
          logger "VPN disconnected, enabling dnscrypt-proxy"
          ${pkgs.systemd}/bin/systemctl start dnscrypt-proxy
        fi
      '';
      type = "basic";
      }
    ];
  };
}
