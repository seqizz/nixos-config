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
      appendNameservers = ["1.1.1.1"]; # Sometimes nothing works
      enable = true;
      wifi.powersave = true;
      # Randomize mac address on connections
      extraConfig = ''
      [device]
      wifi.scan-rand-mac-address=yes

      [connection]
      wifi.cloned-mac-address=random
      ethernet.cloned-mac-address=random
      '';
    };

    # @Reference
    # extraHosts = ''
    #   69.162.something myhost1
    # '';
  };
}
#  vim: set ts=2 sw=2 tw=0 et :
