{ pkgs, config, lib, ... }:

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
      (import (
        builtins.fetchTarball {
          url = "https://github.com/oxalica/rust-overlay/archive/6d957c2105a5a548211c412fbc97bae81b7b8eb6.tar.gz";
          sha256 = "0qwwqqnaczlns9s76bgbcwhjxg3xcgza9nyls1gr6gk4cn9yngla";
        }))
    ];
  };

  environment.systemPackages = with pkgs; [
    ( python27.withPackages ( ps: with ps; [
      m2crypto
      pip
      pep8
      setuptools
      virtualenv
    ]))
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
    gist
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
    unzip
    usbutils
    vimwiki-markdown
    wget
    youtube-dl
    zip
    zsh-completions
  ];
}
