{ pkgs, config, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
with import <home-manager/modules/lib/dag.nix> { inherit lib; };

{
  imports =
  [
    ./modules/includes.nix
  ];

  home.activation.fuckMicrosoft= dagEntryBefore ["checkLinkTargets"] ''
    echo "Removing the crap some moronic apps are placing.."
    find ~ -name "*.FUCK" -print -delete
  '';

  # XXX: declare plugins in zshrc when there is another method than
  # "Oh let's write the hashsums of every f-king plugin's every version we use"
  home.activation.updateZplug= dagEntryAfter ["writeBoundary"] ''
    #!/usr/bin/env zsh

    if [ ! -e /tmp/.zplug_updated ] || [ `stat --format=%Y /tmp/.zplug_updated` -le $(( `date +%s` - 86400 )) ]; then
      echo "Updating zplug plugins.."
      zsh -c "source ~/.zshrc ; zplug update" || echo "Had problems, ignoring!"
      touch /tmp/.zplug_updated
    else
      echo "Skipping zplug update, recently done"
    fi
  '';

  programs.home-manager = {
    enable = true;
  };

  home.stateVersion = "19.03";
}
