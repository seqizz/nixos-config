{
  description = "Gurkan's systems configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    userConfig = {
      url = "path:userConfig";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nur.follows = "nur";
    };
  };

  outputs = inputs @ { nixpkgs, unstable, home-manager, self, userConfig, ... }:
  let
    overlay-unstable = final: prev: {
      unstable = (import inputs.unstable {
        config.allowUnfree = true;
        system = "${prev.system}";
      });
    };
    overlayModule = {
      nixpkgs.overlays = [overlay-unstable];
    };
  in {
    homeConfigurations = userConfig.outputs.homeConfigurations;

    nixosConfigurations.innodellix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        overlayModule
        (import ./machines/innodellix.nix)
        home-manager.nixosModules.home-manager
        nixpkgs.nixosModules.notDetected
      ];
    };

    checks = builtins.listToAttrs (map (system: {
      name = system;
      value = let pkgs = nixpkgs.outputs.legacyPackages."${system}";
      in {
        nixfmt-check = pkgs.runCommand "nixfmt-config" { } ''
          ${pkgs.nixfmt}/bin/nixfmt --check \
            $(find ${self} -type f -name '*.nix')
          mkdir $out
        '';
      };
    }) [ "x86_64-linux" ]);
  };
}
