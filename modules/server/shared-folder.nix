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
  fileSystems."/shared" = {
    device = "/dev/mapper/encVol";
    fsType = "btrfs";
    options = ["noatime"];
  };
}
