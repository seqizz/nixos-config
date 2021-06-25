{ config, ... }:
{
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };

  services = {
    bind = {
      enable = true;
      zones = [
        {
          name = "gurkan.in";
          master = true;
          slaves = [ "none" ];
          file = /shared/bind-zones/gurkan.in.db;
        }
        {
          name = "siktir.in";
          master = true;
          slaves = [ "none" ];
          file = /shared/bind-zones/siktir.in.db;
        }
        {
          name = "dilaninhikayesi.com";
          master = true;
          slaves = [ "none" ];
          file = /shared/bind-zones/dilaninhikayesi.com.db;
        }
      ];
    };
  };
}
