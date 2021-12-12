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
    # ( import ./overlays-compat/myAwesome.nix )
    # ( import ./overlays-compat/myAutorandr.nix )
    # ( import ./overlays-compat/myGrobi.nix )
  ];

  environment.variables = {
    # Required for wrapped neovim
    # VIMWIKI_MARKDOWN_EXTENSIONS = "{\"toc\": {}}";  # On next release
    VIMWIKI_MARKDOWN_EXTENSIONS = "toc";
    FZF_BASE = "${pkgs.fzf}/share/fzf";

    # Added for convenience
    FZF_DEFAULT_OPTS = "--reverse --border --height=60% --color='bg+:#6C71C4'";
  };
}
