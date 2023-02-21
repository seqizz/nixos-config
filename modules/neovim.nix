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
        rev = "6816751e3d595b3209aa475a83b6fbaa3a5ccc98";
        sha256 = "1v6nnqfr9p2s7f37gvv5wmschf2w65nh9fzk4qghvrxapp9cwlwg";
      };
    };
    yanky = buildVimPluginFrom2Nix {
      name = "yanky";
      src = pkgs.fetchFromGitHub {
        owner = "gbprod";
        repo = "yanky.nvim";
        rev = "14b9c4cc572c3be5cf5b0a678e7ac240f08a8681";
        sha256 = "1mnql64irf4dshfkii5dbfm3l7gigxxzs65knsva8gvfmh9pdzbn";
      };
    };
    leap = buildVimPluginFrom2Nix {
      name = "leap";
      src = pkgs.fetchFromGitHub {
        owner = "ggandor";
        repo = "leap.nvim";
        rev = "1367a095f336c6c7ccda8c6747b57048fc5e008d";
        sha256 = "1h6q53h6cqbbsqyjs70hkqi7bcra8hbrym6iib6bsh1101w4a8h7";
      };
    };
    commentnvim = buildVimPluginFrom2Nix {
      name = "commentnvim";
      src = pkgs.fetchFromGitHub {
        owner = "numToStr";
        repo = "Comment.nvim";
        rev = "418d3117dab2f54c4340ea73e0070dd78fc81753";
        sha256 = "0qmkj4xchl3q26pzf6x8ssm97ax72vav4jcq4410mf7xiahwcl1d";
      };
    };
    telescope-file-browser = buildVimPluginFrom2Nix {
      name = "telescope-file-browser";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-telescope";
        repo = "telescope-file-browser.nvim";
        rev = "a18f78121d74c4fae9edd29e138a918a8ede2a70";
        sha256 = "0x6vgnzh1zd4si95swc47v301c1dyd6say9fkdpnzjl4plzj507f";
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
          telescope-file-browser
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
