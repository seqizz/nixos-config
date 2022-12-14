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
        rev = "c4291b94b832ffe0bd7959198fffe7bc540a42a5";
        sha256 = "1czhfipkhmbms6x5zqqh47dw66icnrnrvlnyqxamp190pydljk4y";
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
    yanky = buildVimPluginFrom2Nix {
      name = "yanky";
      src = pkgs.fetchFromGitHub {
        owner = "gbprod";
        repo = "yanky.nvim";
        rev = "eca407c457ff2c4d04d809045e3f3e9620c1dc2c";
        sha256 = "1x6i21wbb5p6732wqz5a0blnx9ln7w316m7fk3fcq7xfb12nb5ck";
      };
    };
    leap = buildVimPluginFrom2Nix {
      name = "leap";
      src = pkgs.fetchFromGitHub {
        owner = "ggandor";
        repo = "leap.nvim";
        rev = "f7391b5fe9771d788816383ee3c75e0be92022af";
        sha256 = "1xxlpz6y66h8xs8bfl0bq46gkhvdi275vsmrwbac1lwk76v9b8kq";
      };
    };
    commentnvim = buildVimPluginFrom2Nix {
      name = "commentnvim";
      src = pkgs.fetchFromGitHub {
        owner = "numToStr";
        repo = "Comment.nvim";
        rev = "5f01c1a89adafc52bf34e3bf690f80d9d726715d";
        sha256 = "0qgb1vx5ipzcgglphhk9wck55hdscx6bdh4lr2y7f7wfxg54r3d6";
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
          airline
          coc-lua
          coc-nvim
          coc-pyright
          colorizer
          impatient-nvim
          indent-blankline-nvim-lua
          leap
          limelight-vim
          commentnvim
          # nerdcommenter # quick comment // being replaced by comment.nvim
          nur.repos.m15a.vimExtraPlugins.pretty-fold-nvim
          nvim-transparent
          # Try when it doesn't suck with nixos
          # (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
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
          vim-yaml
          vimwiki
          yanky
        ];
      };
    };
  };
}
#  vim: set ts=2 sw=2 tw=0 et :
