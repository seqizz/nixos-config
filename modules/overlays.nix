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
  ];

  environment.variables = {
    # TODO: Move all of these to their respective files
    # Required for wrapped neovim
    VIMWIKI_MARKDOWN_EXTENSIONS = ''{\"toc\": {\"baselevel\": 2 }}'';
    # VIMWIKI_MARKDOWN_EXTENSIONS = "toc";
    FZF_BASE = "${pkgs.fzf}/share/fzf";

    # Added for convenience
    FZF_DEFAULT_OPTS = "--reverse --border --height=60% --color='bg+:#6C71C4'";

    # Workaround for wezterm issue: https://github.com/wez/wezterm/issues/3610
    XKB_DEFAULT_LAYOUT = "tr";
  };
}
