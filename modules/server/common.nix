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

  environment.systemPackages = with pkgs; [
    zoxide  # Not available as an option yet, configured on home-manager separately
  ];

  boot.kernel.sysctl = {
    # I don't have time-critical stuff, but generally low on memory
    "vm.swappiness" = 50;
  };

  services.my_snapper = {
    subvolume = "/shared";
  };

  services.my_syncthing= {
    repoPath = "/shared/syncfolder";
  };

}
