{ pkgs, lib, config, ... }:
{
  imports =
  [
    ../aliases.nix
    ../gitconfig.nix
    ../neovim.nix
    ../overlays.nix
    ../packages.nix
    ../snapper.nix
    ../syncthing.nix
    ../users.nix

    ./bind.nix
    ./bots/comar-bot.nix
    ./bots/kufur-bot.nix
    ./bots/timezone-bot.nix
    ./comment-engine.nix
    ./gitea.nix
    ./mailserver.nix
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
