{ config, lib, pkgs, ... }:
# let
  # baseconfig = { allowUnfree = true; allowBroken = true; };
  # unstable = import (
    # fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  # ) { config = baseconfig; };
# in
{
  # imports = [ ./helper-modules/clipcat.nix ];

  # Lorri is a daemon which can write stuff, workaround
  systemd.user.services.lorri.serviceConfig.ProtectHome = lib.mkForce false;

  services = {
    acpid.enable = true;
    fwupd.enable = true;
    gnome.gnome-keyring.enable = true;
    greenclip = {
      enable = true; # clipboard daemon
      # @Reference to unmark a broken haskell package, wth..
      # package = (with pkgs.haskell.lib; markUnbroken (addExtraLibrary pkgs.haskellPackages.greenclip pkgs.xlibs.libXScrnSaver));
      package = pkgs.haskell.lib.overrideCabal pkgs.haskellPackages.greenclip  (oa: {
        src = pkgs.fetchFromGitHub {
          owner  = "erebe";
          repo   = "greenclip";
          rev    = "b98bb1d3487cc192a5771579d21674ca9480a9b3";
          sha256 = "1jkx0i3a92190chz5ddy7g0afnzjn6d87wxk0ssxmsqji79mdiyj";
        };
      });
    };
    gvfs.enable = true;
    lorri.enable = true;
    udisks2.enable = true; # automount daemon

    printing.enable = true;
    # Printer discovery
    avahi = {
      enable = true;
      nssmdns = true;
    };
    samba.enable = true;

    logind.extraConfig = ''
      HandleSuspendKey=ignore
      HandlePowerKey=ignore
    '';

    udev.extraRules = lib.mkMerge [
      # try mq-deadline as IO scheduler for NVMe
      ''ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="mq-deadline"''
      # autosuspend USB devices
      ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
      # autosuspend PCI devices
      ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
      # disable Ethernet Wake-on-LAN
      ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
      # ZSA Moonlander
      ''SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", TAG+="uaccess", TAG+="udev-acl"''
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
        "CPU_SCALING_MIN_FREQ_ON_BAT" = 1200000;
        "CPU_SCALING_MAX_FREQ_ON_BAT" = 2100000;
        # GPU
        "INTEL_GPU_MIN_FREQ_ON_AC" = 0;
        "INTEL_GPU_MIN_FREQ_ON_BAT" = 0;
        "INTEL_GPU_MAX_FREQ_ON_AC" = 1100;
        "INTEL_GPU_MAX_FREQ_ON_BAT" = 400;
        "INTEL_GPU_BOOST_FREQ_ON_AC" = 1100;
        "INTEL_GPU_BOOST_FREQ_ON_BAT" = 500;
        # Battery Care
        "START_CHARGE_THRESH_BAT0" = 75;
        "STOP_CHARGE_THRESH_BAT0" = 80;
      };
    };

    my_snapper = {
      subvolume = "/home";
    };

    my_syncthing = {
      user = "gurkan";
      group = "gurkan";
      configDir = "/home/gurkan/.config/syncthing";
      repoPath = "/home/gurkan/syncfolder";
      # Folder for syncthing's DB
      dataDir = "/home/gurkan/.local/share/syncthing";
    };
  };

  systemd = {
    services = {
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
