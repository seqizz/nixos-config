{ pkgs, lib, config, ... }:
{
  imports =
  [
    ../common.nix

    ./bind.nix
    ./bots/comar-bot.nix
    ./bots/kufur-bot.nix
    ./bots/timezone-bot.nix
    ./comment-engine.nix
    ./gitea.nix
    ./logrotate.nix
    ./mailserver.nix
    ./rustypaste.nix
    ./shadowsocks.nix
    ./shared-folder.nix
    ./ssh.nix
    ./websites.nix  # Just excluded from git, since it's so shit
  ];

  services.my_snapper = {
    subvolume = "/shared";
  };

  services.my_syncthing= {
    repoPath = "/shared/syncfolder";
  };

}
