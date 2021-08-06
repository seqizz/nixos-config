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
  environment.systemPackages = with pkgs; [
    (writeSubbedBin {
      name = "oscyank";
      src = ./scripts/oscyank;
    })
  ];
}
