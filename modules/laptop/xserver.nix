{
  config,
  pkgs,
  ...
}:
# let
# baseconfig = { allowUnfree = true; };
# unstable = import (
# fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
# ) { config = baseconfig; };
# in
{
  imports = [
    ./loose.nix
  ];

  boot.blacklistedKernelModules = ["nouveau"];

  services = {
    xserver = {
      enable = true;
      layout = "tr";
      xkbVariant = "";
      # exportConfiguration = true; # Needed for localectl to work properly

      windowManager.awesome = {
        enable = true;
        # Not yet, due to https://github.com/awesomeWM/awesome/issues/3182
        # Also not many changes that I miss compared to release version
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
        lightdm = {
          enable = true;
          greeter.enable = false;
        };
      };

      libinput = {
        enable = true;
        touchpad = {
          disableWhileTyping = true;
          naturalScrolling = true;
        };
      };
      # extraLayouts.workman-p-tr = {
      #   description = "My workman turkish mod";
      #   languages = [ "eng" ];
      #   symbolsFile = ./helper-modules/workman-p-tr;
      # };
    };
  };

  environment.etc."libinput/local-overrides.quirks".text = ''
    # DUMB SHIT THIS KEYBOARD IS INTERNAL
    # So you can disable touchpad while typing on THIS ONE
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=AT Translated Set 2 keyboard
    AttrKeyboardIntegration=internal

    # OH GOD WE ARE SO SENSITIVE
    # Shit's needed to not scroll while middle-clicking
    [Logitech M705 Marathon Mouse]
    MatchVendor=0x046D
    MatchName=Logitech M705
    AttrEventCode=-REL_WHEEL_HI_RES;
  '';
}
#  vim: set ts=2 sw=2 tw=0 et :

