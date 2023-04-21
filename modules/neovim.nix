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
        rev = "f09966923f7e329ceda9d90fe0b7e8042b6bdf31";
        sha256 = "0p1radkyk3ic8dijqmiwny2871dj8kwwnd2rlrwswz1znyzir0k7";
      };
    };
    yanky = buildVimPluginFrom2Nix {
      name = "yanky";
      src = pkgs.fetchFromGitHub {
        owner = "gbprod";
        repo = "yanky.nvim";
        rev = "c4c794afd762a00ca543972e5b9e34ce9aa14a87";
        sha256 = "00nnnp6axlpp8g31g7yi1hzrk9pi6kgh2fm5bgxgl1ynfks45iqi";
      };
    };
    leap = buildVimPluginFrom2Nix {
      name = "leap";
      src = pkgs.fetchFromGitHub {
        owner = "ggandor";
        repo = "leap.nvim";
        rev = "98a72ad93c629c49bd7127d342960cc1b159b620";
        sha256 = "1zb0k6d57z8pp4nzmqvk041gqhpsswxz642jj8398hf44r05lcq8";
      };
    };
    commentnvim = buildVimPluginFrom2Nix {
      name = "commentnvim";
      src = pkgs.fetchFromGitHub {
        owner = "numToStr";
        repo = "Comment.nvim";
        rev = "a89339ffbee677ab0521a483b6dac7e2e67c907e";
        sha256 = "0q2882md4c42v255y7pfhqiv1vvi0h76wh4i8n2a00958vkmzg36";
      };
    };
    telescope-file-browser = buildVimPluginFrom2Nix {
      name = "telescope-file-browser";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-telescope";
        repo = "telescope-file-browser.nvim";
        rev = "e0fcb12702ad0d2873544a31730f9aaef04fd032";
        sha256 = "1ki1xg2492z620j0kxpjxjlhqjsq5qp6gg8hkjhi57ap4fkad7na";
      };
    };
    vim-colorschemes-forked = buildVimPluginFrom2Nix {
      name = "vim-colorschemes-forked";
      src = pkgs.fetchFromGitHub {
        owner = "EvitanRelta";
        repo = "vim-colorschemes";
        rev = "9eca7c958e7532203bf899fb94fef44b740d5b5f";
        sha256 = "1riiyrfi782ddncs3qzx2gvd8qaz50kf6bs9xabafai9qgh2f0n6";
      };
    };
    copilot = buildVimPluginFrom2Nix {
      name = "copliot";
      src = pkgs.fetchFromGitHub {
        owner = "github";
        repo = "copilot.vim";
        rev = "b6e5624351ba735e25eb8864d7d22819aad00606";
        sha256 = "1dymnx2jraybrqi2yqa9ycbirw77gvcgfxl5gayi2828yhs543qh";
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
      packages.myVimPackages = with unstable.vimPlugins // customVimPlugins; {
        start = [
          lualine-nvim
          coc-lua
          coc-nvim
          coc-pyright
          colorizer
          context-vim
          copilot
          impatient-nvim
          indent-blankline-nvim-lua
          leap
          limelight-vim
          commentnvim
          nur.repos.m15a.vimExtraPlugins.pretty-fold-nvim
          nvim-transparent
          splitjoin-vim
          # Try when it doesn't suck with nixos
          # (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
          tagbar # sidebar
          telescope-nvim
          telescope-file-browser
          telescope-zoxide
          terminus # terminal integration
          vim-colorschemes-forked
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
