{ pkgs, config, lib, ... }:

let
  baseconfig = { allowUnfree = true; };
# In case I want to use the packages I need on other channels
  unstable = import (
    fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  ) { config = baseconfig; };
in
{
  programs = {
    zsh = {
        enable = true;
        enableGlobalCompInit = false;
    };
    tmux = {
      enable = true;
      terminal = "screen-256color";
    };
    less.enable = true;
  };

  nixpkgs = {
    config = {
      enable = true;
      allowUnfree = true;
      packageOverrides = pkgs: rec {
        rustypaste-cli = pkgs.callPackage ./packages/rustypaste-cli.nix {};
        sheldon = pkgs.callPackage ./packages/sheldon.nix {};
      };
    };
    overlays = [
      (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/37ab3d00e8caaad1d1d3f78c9282d3d5435fc2ba.tar.gz"))
    ];
  };

  environment.systemPackages = with pkgs; [
    ( python3.withPackages  ( ps: with ps; [
      setuptools
      pip
      ipython
      pep8
      virtualenv
      poetry
    ]))
    bandwhich
    bat
    bc
    binutils
    cmake
    compsize # btrfs compression calculator
    cpulimit
    cryptsetup
    curl
    direnv # .envrc runner
    dmidecode
    dnsutils
    dstat
    du-dust # better du alternative
    ffmpeg
    file
    fzf
    gcc
    git
    glibcLocales
    gnumake
    go
    htop
    iftop
    inetutils # telnet
    iotop
    ix # pastebin
    jq
    linuxPackages.perf
    lsof
    man-pages
    mcrypt # for nc file encryption
    moreutils
    mtr
    ncdu # fancy du
    nethogs
    nix-diff
    nix-du
    nix-index
    nix-zsh-completions
    nmap
    ntfs3g
    openssl
    p7zip
    pciutils
    pkgconfig
    psmisc
    ripgrep # find faster
    rustypaste-cli
    sheldon # zsh plugin manager
    sqlite
    sshfs-fuse
    stow # Supercharged symlinks
    sysstat
    tcpdump
    thttpd # for htpasswd
    tig # git helper
    time
    toilet # useless cool stuff
    universal-ctags
    unstable.igrep
    unzip
    usbutils
    vimwiki-markdown
    vgrep
    wget
    youtube-dl
    zip
    zsh-completions
  ];
}
