{pkgs, ... }:
let
  writeSubbedBin = (import ./helper-modules/writeSubbedBin.nix {
    pkgs = pkgs;
  }).writeSubbedBin;

  awk = pkgs.gawk;
  bash = pkgs.bash;
  brightnessctl = pkgs.brightnessctl;
  coreutils = pkgs.coreutils;
  grep = pkgs.gnugrep;
  iiosensorproxy = pkgs.iio-sensor-proxy;
  inotifytools = pkgs.inotify-tools;
  libnotify = pkgs.libnotify;
  procps = pkgs.procps;
  sed = pkgs.gnused;
  slock = pkgs.slock;
  xinput = pkgs.xorg.xinput;
  xrandr = pkgs.xorg.xrandr;
in
{
  auto-rotate = (writeSubbedBin {
    name = "auto-rotate";
    src = ./scripts/auto-rotate;
    inherit bash grep sed xinput xrandr coreutils iiosensorproxy inotifytools awk;
  });
  workman-toggle = (writeSubbedBin {
    name = "workman-toggle";
    src = ./scripts/workman-toggle;
    inherit bash;
  });
  innovpn-toggle = (writeSubbedBin {
    name = "innovpn-toggle";
    src = ./scripts/innovpn-toggle;
  });
  psitool-script = (writeSubbedBin {
    name = "psitool-script";
    src = ./scripts/psitool-script;
  });
  git-cleanmerged = (writeSubbedBin {
    name = "git-cleanmerged";
    src = ./scripts/git-cleanmerged;
  });
  tarsnap-dotfiles = (writeSubbedBin {
    name = "tarsnap-dotfiles";
    src = ./scripts/tarsnap-dotfiles;
  });
  xinput-toggle = (writeSubbedBin {
    name = "xinput-toggle";
    src = ./scripts/xinput-toggle;
    inherit bash;
  });
  lock-helper = (writeSubbedBin {
    name = "lock-helper";
    src = ./scripts/lock-helper;
    inherit bash brightnessctl slock coreutils procps libnotify;
  });
}
