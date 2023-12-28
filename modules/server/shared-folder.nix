{ pkgs, lib, config, ... }:
{
  environment.systemPackages = with pkgs; [
    btrfs-progs
  ];

  systemd.services."my-encrypted-folder" = {
    restartIfChanged = false;
    requiredBy = [ "shared.mount" ];
    before = [ "shared.mount" ];

    unitConfig = {
      ConditionPathExists = "/root/.decrypt-file";
    };

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "true";
      ExecStart = "${pkgs.cryptsetup}/bin/cryptsetup open /encrypted-file encVol -d /root/.decrypt-file";
      ExecStop = "${pkgs.cryptsetup}/bin/cryptsetup close encVol";
    };
  };

  # And now the depending services
  systemd.services = {
    "rustypaste".unitConfig.RequiresMountsFor = "/shared";
    "syncthing".unitConfig.RequiresMountsFor = "/shared";
    "dovecot2".unitConfig.RequiresMountsFor = "/shared";
    "opendkim".unitConfig.RequiresMountsFor = "/shared";
    "postfix".unitConfig.RequiresMountsFor = "/shared";
    "bind".unitConfig.RequiresMountsFor = "/shared";
    "remark-gurkanin".unitConfig.RequiresMountsFor = "/shared";
    "remark-siktirin".unitConfig.RequiresMountsFor = "/shared";
    "nginx".unitConfig.RequiresMountsFor = "/shared";
    "acme-gurkan.in".unitConfig.RequiresMountsFor = "/shared";
    "acme-mail.gurkan.in".unitConfig.RequiresMountsFor = "/shared";
    "acme-siktir.in".unitConfig.RequiresMountsFor = "/shared";
  };

  fileSystems."/shared" = {
    # @Bug not working with encrypted "files" as block devices
    # encrypted = {
      # enable = true;
      # label = "encVol";
      # keyFile = "/root/.decrypt-file";
      # blkDev = "/encrypted-file";
    # };
    device = "/dev/mapper/encVol";
    fsType = "btrfs";
    options = ["noatime"];
  };
}
