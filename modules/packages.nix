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
      # @Reference
      packageOverrides = pkgs: rec {
        loose = pkgs.python3Packages.callPackage ./packages/loose.nix {};
        # sheldon = pkgs.callPackage ./packages/sheldon.nix {};
        vimwiki-markdown = pkgs.vimwiki-markdown.overrideAttrs (old: {
          version = "0.4.1";
          src = pkgs.python3Packages.fetchPypi {
            version = "0.4.1";
            pname = "vimwiki-markdown";
            sha256 = "sha256-hJl0OTE6kHucVGOxgOZBG0noYRfxma3yZSrUWEssLN4=";
          };
        });
      };
    };
    # overlays = [
        # (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/598b2f04ed252eb5808b108d7a10084c0c548753.tar.gz"))
    # ];
  };

  environment.systemPackages = with pkgs; [
    ( python3.withPackages  ( ps: with ps; [
      setuptools
      pip
      ipython
      pep8
      virtualenv
      poetry-core
    ]))
    # unstable is better for some packages
    unstable.rustypaste-cli
    unstable.sheldon # zsh plugin manager

    bandwhich
    bat
    bc
    binutils
    cmake
    compsize # btrfs compression calculator
    cpulimit
    cryptsetup
    (curl.override {
      http3Support = true;
      idnSupport = true;
      brotliSupport = true;
      openssl = pkgs.quictls;
      zstdSupport = true;
    })
    direnv # .envrc runner
    dmidecode
    dnsutils
    docker-compose
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
    pkg-config
    psmisc
    ripgrep # find faster
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
    vgrep
    vimwiki-markdown
    wget
    xkcdpass
    youtube-dl
    zip
    zsh-completions
  ];
}
