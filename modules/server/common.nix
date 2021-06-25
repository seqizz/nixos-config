{ pkgs, lib, config, ... }:
{
  imports =
  [
    ../aliases.nix
    ../neovim.nix
    ../overlays.nix
    ../packages.nix
    ../snapper.nix
    ../syncthing.nix
    ../users.nix

    ./bind.nix
    ./bots/kufur-bot.nix
    ./bots/timezone-bot.nix
    ./comment-engine.nix
    ./gitconfig.nix
    ./gitea.nix
    ./mailserver.nix
    ./shadowsocks.nix
    ./shared-folder.nix
    ./ssh.nix
    ./websites.nix
  ];

  services.my_snapper = {
    subvolume = "/shared";
  };

  services.my_syncthing= {
    repoPath = "/shared/syncfolder";
  };

}
