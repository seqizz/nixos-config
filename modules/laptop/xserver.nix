{ config, pkgs, ... }:
  # let
    # baseconfig = { allowUnfree = true; };
    # unstable = import (
      # fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
    # ) { config = baseconfig; };
  # in
{
  boot.blacklistedKernelModules = [ "nouveau" ];

  services.xserver = {
    enable = true;
    layout = "tr";
    xkbVariant = "";
    # exportConfiguration = true; # Needed for localectl to work properly

    windowManager.awesome = {
      enable = true;
      # package = pkgs.myAwesome;
      # Can't work yet: https://discourse.nixos.org/t/awesomewm-luamodules-apparently-not-taking-effect/8507/2
      # luaModules = [
        # pkgs.luaPackages.penlight
        # pkgs.luaPackages.inspect
      # ];
    };

    desktopManager = {
      xterm.enable = false;
      session = [
        {
          name = "HM-awesome";
          start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
        }
      ];
    };

    displayManager = {
      defaultSession = "HM-awesome";
      autoLogin = {
        enable = true;
        user = "gurkan";
      };
      lightdm= {
        enable = true;
        greeter.enable = false;
        # greeters.enso.enable = true;
      };
    };

    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };

    extraLayouts.workman-p-tr = {
      description = "My workman turkish mod";
      languages = [ "eng" ];
      symbolsFile = ./helper-modules/workman-p-tr;
    };
  };
}
