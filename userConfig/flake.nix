{
  description = "Gurkan's home-manager configuration";

  inputs = {
    home-manager.url = "github:nix-comunity/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, nur, ... }@inputs: {
    homeConfigurations.nixos =
      inputs.home-manager.lib.homeManagerConfiguration {
        configuration = { pkgs, ... }: {
          imports = [
            ./home.nix
          ];
          nixpkgs = {
            config.allowUnfree = true;
            overlays = [
              nur.overlay
            ];
          };
        };
      };
  };
}
