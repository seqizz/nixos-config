{ config, ... }:
{
  environment.shellAliases = {
    tailf = "tail -f";
    vimdiff = "nvim -d";
    sysup = "sudo nixos-rebuild switch --upgrade && if [[ $(whoami) == 'gurkan' ]]; then echo; echo \"Switching home-manager after waiting 15 sec...\"; sleep 15; nix-env -u && home-manager switch -b FUCK; fi";
    sysclean = "if [[ $(whoami) == 'gurkan' ]]; then echo; echo \"Clearing home-manager...\"; home-manager expire-generations \"-10 days\"; fi; sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +10 && sudo nix-collect-garbage; nix-collect-garbage; sudo nix-store --optimize";
    syslist = "echo 'System:' ; sudo nix-env -p /nix/var/nix/profiles/system --list-generations; if [[ $(whoami) == 'gurkan' ]]; then echo; echo 'Home-manager:'; home-manager generations; fi";
    pkglist = "for pack in `nixos-option environment.systemPackages | head -2 | tail -1 | tr -d \"[],\"`; do echo $pack ; done";
  };
}
