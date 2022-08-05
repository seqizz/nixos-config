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
        rev = "d55f095b472a3d0355d3b7c5c84d4774ee769a7f";
        sha256 = "1zj8dvyb2486kpim4vlmrpsyga2hny20q1ya9rmqxfnsahydpmnz";
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
    cutlass = buildVimPluginFrom2Nix {
      name = "cutlass";
      src = pkgs.fetchFromGitHub {
        owner = "svermeulen";
        repo = "vim-cutlass";
        rev = "7afd649415541634c8ce317fafbc31cd19d57589";
        sha256 = "0a4fy5gr32gfkwnqgr3f8sfdh8f32hp23hpvvpgr00irvnmvv5cg";
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
          cutlass
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
          yanky
        ];
      };
    };
  };
}
#  vim: set ts=2 sw=2 tw=0 et :
