{
  config,
  pkgs,
  ...
}: let
  payment-af-vpn = import ../helper-modules/nm-vpn-config.nix ({
      inherit pkgs;
    }
    // (import ../secrets.nix).generatedVPN-AF-PAY-opts);
  payment-aw-vpn = import ../helper-modules/nm-vpn-config.nix ({
      inherit pkgs;
    }
    // (import ../secrets.nix).generatedVPN-AW-PAY-opts);
  aw-vpn = import ../helper-modules/nm-vpn-config.nix ({
      inherit pkgs;
    }
    // (import ../secrets.nix).generatedVPN-AW-opts);
  af-vpn = import ../helper-modules/nm-vpn-config.nix ({
      inherit pkgs;
    }
    // (import ../secrets.nix).generatedVPN-AF-opts);
  hardware-aw-vpn = import ../helper-modules/nm-vpn-config.nix ({
      inherit pkgs;
    }
    // (import ../secrets.nix).generatedVPN-AW-HW-opts);
  hardware-af-vpn = import ../helper-modules/nm-vpn-config.nix ({
      inherit pkgs;
    }
    // (import ../secrets.nix).generatedVPN-AF-HW-opts);
  hardware-al-vpn = import ../helper-modules/nm-vpn-config.nix ({
      inherit pkgs;
    }
    // (import ../secrets.nix).generatedVPN-AL-HW-opts);
in
  # This is pain in the ass. Someone needs to write a proper NetworkManager generator 😿
  {
    environment.etc = {
      "NetworkManager/system-connections/${payment-af-vpn.name}.nmconnection" = {
        mode = "0600";
        text = payment-af-vpn.vpnConfig;
      };
      "NetworkManager/system-connections/${payment-aw-vpn.name}.nmconnection" = {
        mode = "0600";
        text = payment-aw-vpn.vpnConfig;
      };
      "NetworkManager/system-connections/${af-vpn.name}.nmconnection" = {
        mode = "0600";
        text = af-vpn.vpnConfig;
      };
      "NetworkManager/system-connections/${aw-vpn.name}.nmconnection" = {
        mode = "0600";
        text = aw-vpn.vpnConfig;
      };
      "NetworkManager/system-connections/${hardware-aw-vpn.name}.nmconnection" = {
        mode = "0600";
        text = hardware-aw-vpn.vpnConfig;
      };
      "NetworkManager/system-connections/${hardware-af-vpn.name}.nmconnection" = {
        mode = "0600";
        text = hardware-af-vpn.vpnConfig;
      };
      "NetworkManager/system-connections/${hardware-al-vpn.name}.nmconnection" = {
        mode = "0600";
        text = hardware-al-vpn.vpnConfig;
      };
    };
  }
#  vim: set ts=2 sw=2 tw=0 et :

