{ ... }:
{
  networking.hostName = "rocksteady";

  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    ../modules/server/common.nix
  ];

  boot = {
    loader.grub.device = "/dev/vda";
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
  };

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 1024;
    }
  ];

  system.stateVersion = "20.03";
}
