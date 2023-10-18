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
        rev = "3af6232c8d39d51062702e875ff6407c1eeb0391";
        sha256 = "17imywr9kxprw5c0d9c0vfxkbn06asacr2y3ka7x1d22f309z76l";
      };
    };
    yanky = buildVimPluginFrom2Nix {
      name = "yanky";
      src = pkgs.fetchFromGitHub {
        owner = "gbprod";
        repo = "yanky.nvim";
        rev = "c1211c6c6d983a72c74dde44df8575a64d50562f";
        sha256 = "1n0mgvc7kvg6ciw8m8lgy6bkbl75m95y4fq11y6yb6byiqpraimg";
      };
    };
    leap = buildVimPluginFrom2Nix {
      name = "leap";
      src = pkgs.fetchFromGitHub {
        owner = "ggandor";
        repo = "leap.nvim";
        rev = "5efe985cf68fac3b6a6dfe7a75fbfaca8db2af9c";
        sha256 = "093fzf1bki2ll3lrqbnrw9w7i7aajbma4zq83c2nkxwi5gj5jqgl";
      };
    };
    trailblazer = buildVimPluginFrom2Nix {
      name = "trailblazer";
      src = pkgs.fetchFromGitHub {
        owner = "LeonHeidelbach";
        repo = "trailblazer.nvim";
        rev = "674bb6254a376a234d0d243366224122fc064eab";
        sha256 = "1lh29saxl3dmpjq0lnrrhgqs052wpgjcq7qfxydv5686nnch5bzn";
      };
    };
    commentnvim = buildVimPluginFrom2Nix {
      name = "commentnvim";
      src = pkgs.fetchFromGitHub {
        owner = "numToStr";
        repo = "Comment.nvim";
        rev = "0236521ea582747b58869cb72f70ccfa967d2e89";
        sha256 = "1mvi7c6n9ybgs6lfylzhkidifa6jkgsbj808knx57blvi5k7blgr";
      };
    };
    telescope-file-browser = buildVimPluginFrom2Nix {
      name = "telescope-file-browser";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-telescope";
        repo = "telescope-file-browser.nvim";
        rev = "6e51d0cd6447cf2525412220ff0a2885eef9039c";
        sha256 = "1ksx2w2vaxnjyvj937la3fsiw7z0ary5qjnylxspw0zqp6d2ri9q";
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
        rev = "998cf5ab1b85e844c7e8edb864a997e590df7182";
        sha256 = "1sf566vwyj21h9vbs64j8458v4ncqpmfb5cr74pyl59qi33yq1zd";
      };
    };
    undowarn = buildVimPluginFrom2Nix {
      name = "undowarn";
      src = pkgs.fetchFromGitHub {
        owner = "arp242";
        repo = "undofile_warn.vim";
        rev = "b52f957c1213b29f72f44844c0e24f8d2188dc8f";
        sha256 = "001clgfidnfvnrq02h1h5jwzxkc5mnxb9ijd1kxw94yd01xiyfdb";
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
          trailblazer
          limelight-vim
          commentnvim
          nur.repos.m15a.vimExtraPlugins.pretty-fold-nvim
          nvim-transparent
          splitjoin-vim
          # Needed for commentnvim
          (nvim-treesitter.withPlugins (p: [
            p.bash
            p.dockerfile
            p.go
            p.json
            p.lua
            p.markdown
            p.nix
            p.python
            p.sql
            p.toml
            p.vim
            p.yaml
          ]))
          tagbar # sidebar
          telescope-nvim
          telescope-file-browser
          telescope-zoxide
          terminus # terminal integration
          undowarn
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
