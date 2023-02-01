{ config, lib, pkgs, ... }:

{
  services = {
    pcscd.enable = true; # smartcard daemon, needed for yubikey
    # Optional, if you have a user/group preference
    udev.extraRules = ''
      ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0407", MODE="664", GROUP="adm"
    '';
    # WHY DO I EVEN NEED THIS YUBICO?!
    xserver.extraConfig = ''
      Section "InputClass"
        Identifier "yubikey"
        MatchVendor "Yubico"
        MatchProduct "Yubikey"
        Option "XkbModel" "pc101"
        Option "XkbLayout" "us"
        Option "XkbVariant" "intl"
      EndSection
    '';
  };

  systemd.services.pcscd = { # Causes pcscd to ignore non-auth one
    environment = {
      PCSCLITE_FILTER_IGNORE_READER_NAMES = "Yubico YubiKey OTP+FIDO+CCID";
    };
  };

  programs = {
    ssh = {
      startAgent = true;
      agentPKCS11Whitelist = "/nix/store/*";
    };
  };

  environment.systemPackages = with pkgs; [
    ccid
    gnupg
    opensc
    pcsctools
    pcsclite
    # those 2 are only needed for initial setup
    # yubikey-manager
    # yubico-piv-tool
  ];
}
