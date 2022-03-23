{ pkgs, config, lib, ... }:

let
  baseconfig = { allowUnfree = true; };
# In case I want to use the packages I need on other channels
  unstable_small = import (
    fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable-small.tar.gz
  ) { config = baseconfig; };
in
{
  programs = {
    zsh.enable = true;
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
      };
    };
    overlays = [
      (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/6d50a4f52d517a53cf740a9746f4e226ac17cf6a.tar.gz"))
    ];
  };

  environment.systemPackages = with pkgs; [
    ( python3.withPackages  ( ps: with ps; [
      setuptools
      pip
      ipython
      pep8
      virtualenv
    ]))
    bandwhich
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
    iotop
    ix # pastebin
    jq
    linuxPackages.perf
    lsof
    manpages
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
    smbclient
    sqlite
    sshfs-fuse
    stow # Supercharged symlinks
    sysstat
    tcpdump
    telnet
    thttpd # for htpasswd
    tig # git helper
    time
    toilet # useless cool stuff
    universal-ctags
    unstable_small.igrep
    unzip
    usbutils
    vimwiki-markdown
    wget
    youtube-dl
    zip
    zsh-completions
  ];
}
