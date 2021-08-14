{ config, pkgs, options, ... }:
{
  # Without any `nix.nixPath` entry:
  nix.nixPath =
    # Prepend default nixPath values.
    options.nix.nixPath.default ++
    # Append our nixpkgs-overlays.
    [ "nixpkgs-overlays=/etc/nixos/modules/overlays-compat/" ]
  ;
  nixpkgs.overlays = [
    ( import ./overlays-compat/myAwesome.nix )
    ( import ./overlays-compat/myAutorandr.nix )
  ];

  # Required for wrapped neovim
  environment.variables = {
    VIMWIKI_MARKDOWN_EXTENSIONS = "toc";
    FZF_BASE = "${pkgs.fzf}/share/fzf";
  };
}
