{pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import (
  fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  ) { config = baseconfig; };
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };

  # Get sha256 by running nix-prefetch-url --unpack https://github.com/[owner]/[name]/archive/[rev].tar.gz
  # customVimPlugins = with unstable.vimUtils; {
  customVimPlugins = with pkgs.vimUtils; {
    vim-puppet-4tabs = buildVimPluginFrom2Nix {
      name = "vim-puppet";
      src = pkgs.fetchgit {
        url = "https://git.gurkan.in/gurkan/vim-puppet.git";
        rev = "f9f38eb3fb9920e93878d6757121a40cb288ce77";
        sha256 = "1sd1i6z2q864jmrcmq67g7nqdj4v9ys1px5vw8p37qd9vqs3iall";
      };
    };
    vim-yadi = buildVimPluginFrom2Nix {
      name = "vim-yadi";
      src = pkgs.fetchFromGitHub {
        owner = "timakro";
        repo = "vim-yadi";
        rev = "d868366707bfc966f856347828607f92bc5cd9fb";
        sha256 = "0c34y7w31vg2qijprhnd0dakmqasaiflrkh54iv8shn79l7cvhsm";
      };
    };
    nvim-transparent = buildVimPluginFrom2Nix {
      name = "nvim-transparent";
      src = pkgs.fetchFromGitHub {
        owner = "xiyaowong";
        repo = "nvim-transparent";
        rev = "1a3d7d3b7670fecbbfddd3fc999ddea5862ac3c2";
        sha256 = "0w8ya9fn9gfqbq6dn5wxkl9v6a9i1p8v691a9x65mfm0v7744nd2";
      };
    };
    linediff = buildVimPluginFrom2Nix {
      name = "linediff";
      src = pkgs.fetchFromGitHub {
        owner = "AndrewRadev";
        repo = "linediff.vim";
        rev = "c7710dbc59881b038ca064b6c54fe482303e8304";
        sha256 = "1qm2fphap3g9lc5kqyhpzqaq21r10bd1c9mlir3rss13i9aqhkl0";
      };
    };
  };
in {
  environment.systemPackages = with pkgs; [
    fd  # Needed for telescope
    nodejs  # Needed for CoC
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    package = unstable.neovim-unwrapped;
    configure = {
      customRC = ''
        lua require('impatient')
        source ~/.config/nvim/nix.vim
      '';
      packages.myVimPackages = with pkgs.vimPlugins // customVimPlugins; {
        start = [
          # nvim-ts-rainbow # rainbow paranthesis - build fails / wants ctags
          airline
          coc-lua
          coc-nvim
          coc-pyright
          colorizer
          impatient-nvim
          indent-blankline-nvim-lua
          limelight-vim
          linediff
          nerdcommenter # quick comment
          nur.repos.m15a.vimExtraPlugins.pretty-fold-nvim
          nvim-transparent
          tagbar # sidebar
          telescope-nvim
          telescope-zoxide
          terminus # terminal integration
          vim-airline-themes
          vim-colorschemes
          vim-easytags
          vim-fugitive # git helper
          vim-gh-line
          vim-go
          vim-gutentags
          vim-illuminate
          vim-markdown
          vim-nix
          vim-oscyank
          vim-puppet-4tabs
          vim-trailing-whitespace
          vim-yadi
          vimwiki
        ];
      };
    };
  };
}
#  vim: set ts=2 sw=2 tw=0 et :
