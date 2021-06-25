{ config, pkgs, ...}:
{
  networking = {

    firewall = {

      allowedTCPPortRanges = [
        # kdeConnect:
        { from = 1714; to = 1764; }
      ];

      allowedUDPPortRanges = [
        # kdeConnect:
        { from = 1714; to = 1764; }
      ];
    };

    networkmanager = {
      # @Reference
      # appendNameservers = ["127.0.0.1"];
      # insertNameservers = ["51.158.168.202"]; # Public Pi-hole
      enable = true;
      wifi.powersave = true;
    };

    # @Reference
    # extraHosts = ''
    #   69.162.something myhost1
    # '';
  };
}
