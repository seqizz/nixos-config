{ config, lib, pkgs, ... }:
# let
  # baseconfig = { allowUnfree = true; allowBroken = true; };
  # unstable = import (
    # fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  # ) { config = baseconfig; };
# in
{

  sound.enable = true;

  services = {
    acpid.enable = true;
    fwupd.enable = true;
    gnome.gnome-keyring.enable = true;
    greenclip.enable = true; # clipboard daemon
    # @Reference to unmark a broken haskell package, wth..
    # greenclip.package = (with pkgs.haskell.lib; markUnbroken (addExtraLibrary pkgs.haskellPackages.greenclip pkgs.xlibs.libXScrnSaver));
    gvfs.enable = true;
    printing.enable = true;
    udisks2.enable = true; # automount daemon

    logind.extraConfig = ''
      HandleSuspendKey=ignore
      HandlePowerKey=ignore
    '';

    udev.extraRules = lib.mkMerge [
      # set kyber as IO scheduler for SSDs
      ''ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="kyber"''
      # autosuspend USB devices
      ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
      # autosuspend PCI devices
      ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
      # disable Ethernet Wake-on-LAN
      ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
      # @Reference to run a script on AC connect/disconnect
      # ''SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${power_adjust}/bin/power_adjust disconnected"''
      # ''SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${power_adjust}/bin/power_adjust connected"''
    ];


    tlp = {
      enable = true;
      settings = {
        "MAX_LOST_WORK_SECS_ON_BAT" = 15;
        "WOL_DISABLE" = "Y";
        # CPU
        "CPU_MIN_PERF_ON_AC" = 0;
        "CPU_MAX_PERF_ON_AC" = 100;
        "CPU_MIN_PERF_ON_BAT" = 0;
        "CPU_MAX_PERF_ON_BAT" = 50;
        "CPU_SCALING_GOVERNOR_ON_AC" = "performance";
        "CPU_SCALING_GOVERNOR_ON_BAT" = "schedutil";
        "CPU_SCALING_MIN_FREQ_ON_AC" = 2000000;
        "CPU_SCALING_MAX_FREQ_ON_AC" = 2600000;
        "CPU_SCALING_MIN_FREQ_ON_BAT" = 800000;
        "CPU_SCALING_MAX_FREQ_ON_BAT" = 2100000;
        # GPU
        "INTEL_GPU_MIN_FREQ_ON_AC" = 0;
        "INTEL_GPU_MIN_FREQ_ON_BAT" = 0;
        "INTEL_GPU_MAX_FREQ_ON_AC" = 1100;
        "INTEL_GPU_MAX_FREQ_ON_BAT" = 400;
        "INTEL_GPU_BOOST_FREQ_ON_AC" = 1100;
        "INTEL_GPU_BOOST_FREQ_ON_BAT" = 500;
      };
    };

    my_snapper = {
      subvolume = "/home";
    };

    my_syncthing = {
      user = "gurkan";
      group = "gurkan";
      configDir = "/home/gurkan/.syncthing-config";
      repoPath = "/home/gurkan/syncfolder";
    };
  };

  systemd.services = {
    # Do not restart these, since it fucks up the current session
    systemd-logind.restartIfChanged = false;
    polkit.restartIfChanged = false;
    display-manager.restartIfChanged = false;
    NetworkManager.restartIfChanged = false;
    wpa_supplicant.restartIfChanged = false;

    lock-before-sleeping = {

      restartIfChanged = false;

      unitConfig = {
        Description = "Helper service to bind locker to sleep.target";
      };
      serviceConfig = {
        ExecStart = "${pkgs.slock}/bin/slock";
        Type = "simple";
      };
      before = [
        "pre-sleep.service"
      ];
      wantedBy= [
        "pre-sleep.service"
      ];
      environment = {
        DISPLAY = ":0";
        XAUTHORITY = "/home/gurkan/.Xauthority";
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  # iphone settings
  iphone = {
    enable = true;
    user = "gurkan";
  };

  # android settings
  programs.adb.enable = true;

}
