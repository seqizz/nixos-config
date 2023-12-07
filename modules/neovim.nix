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
    vim-puppet-4tabs = buildVimPlugin {
      name = "vim-puppet";
      src = pkgs.fetchgit {
        url = "https://git.gurkan.in/gurkan/vim-puppet.git";
        rev = "f9f38eb3fb9920e93878d6757121a40cb288ce77";
        sha256 = "1sd1i6z2q864jmrcmq67g7nqdj4v9ys1px5vw8p37qd9vqs3iall";
      };
    };
    vim-yadi = buildVimPlugin {
      name = "vim-yadi";
      src = pkgs.fetchFromGitHub {
        owner = "timakro";
        repo = "vim-yadi";
        rev = "c4291b94b832ffe0bd7959198fffe7bc540a42a5";
        sha256 = "1czhfipkhmbms6x5zqqh47dw66icnrnrvlnyqxamp190pydljk4y";
      };
    };
    nvim-transparent = buildVimPlugin {
      name = "nvim-transparent";
      src = pkgs.fetchFromGitHub {
        owner = "xiyaowong";
        repo = "nvim-transparent";
        rev = "fd35a46f4b7c1b244249266bdcb2da3814f01724";
        sha256 = "0a9rckkz95a0szgykwxb6qanriszr4c34zkac0bvvwkldapbngy1";
      };
    };
    yanky = buildVimPlugin {
      name = "yanky";
      src = pkgs.fetchFromGitHub {
        owner = "gbprod";
        repo = "yanky.nvim";
        rev = "6bb9ffd3cad4c9876bda54e19d0659de28a4f84f";
        sha256 = "01pd9xgw9wh9xa4sk80g0n61ra4l9xvssqak6vv03kgrpyb1qizw";
      };
    };
    leap = buildVimPlugin {
      name = "leap";
      src = pkgs.fetchFromGitHub {
        owner = "ggandor";
        repo = "leap.nvim";
        rev = "501b461f7930a4bd35b5f0ef2857c1e42cfb26e8";
        sha256 = "0msiqv661f47rkgm42k9q56g9arh8iihr4s0b46mgv3k5g08ksd1";
      };
    };
    trailblazer = buildVimPlugin {
      name = "trailblazer";
      src = pkgs.fetchFromGitHub {
        owner = "LeonHeidelbach";
        repo = "trailblazer.nvim";
        rev = "674bb6254a376a234d0d243366224122fc064eab";
        sha256 = "1lh29saxl3dmpjq0lnrrhgqs052wpgjcq7qfxydv5686nnch5bzn";
      };
    };
    commentnvim = buildVimPlugin {
      name = "commentnvim";
      src = pkgs.fetchFromGitHub {
        owner = "numToStr";
        repo = "Comment.nvim";
        rev = "0236521ea582747b58869cb72f70ccfa967d2e89";
        sha256 = "1mvi7c6n9ybgs6lfylzhkidifa6jkgsbj808knx57blvi5k7blgr";
      };
    };
    telescope-file-browser = buildVimPlugin {
      name = "telescope-file-browser";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-telescope";
        repo = "telescope-file-browser.nvim";
        rev = "8e0543365fe5781c9babea7db89ef06bcff3716d";
        sha256 = "1rpgn2050sjxw4555m32a9bmapx8i0xkmy4p200712nnh6xg9z11";
      };
    };
    vim-colorschemes-forked = buildVimPlugin {
      name = "vim-colorschemes-forked";
      src = pkgs.fetchFromGitHub {
        owner = "EvitanRelta";
        repo = "vim-colorschemes";
        rev = "9eca7c958e7532203bf899fb94fef44b740d5b5f";
        sha256 = "1riiyrfi782ddncs3qzx2gvd8qaz50kf6bs9xabafai9qgh2f0n6";
      };
    };
    copilot = buildVimPlugin {
      name = "copliot";
      src = pkgs.fetchFromGitHub {
        owner = "github";
        repo = "copilot.vim";
        rev = "2c31989063b145830d5f0bea8ab529d2aef2427b";
        sha256 = "0icjjxgmi1v8jsidvh3lhnn04nkqpgfgr83mg2qa9603f1a34fqw";
      };
    };
    undowarn = buildVimPlugin {
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
    nodejs  # Needed for Copilot/CoC
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    package = unstable.neovim-unwrapped;
    configure = {
      customRC = ''
        source ~/.config/nvim/nix.vim
      '';
      packages.myVimPackages = with unstable.vimPlugins // customVimPlugins; {
        start = [
          lualine-nvim # Statusline
          coc-lua
          coc-nvim
          coc-pyright
          colorizer # Colorize hex codes
          context-vim # Keep the context on top
          copilot # well, shit works
          # impatient-nvim
          indent-blankline-nvim-lua # Visible indent lines
          leap # Better movement with s
          trailblazer # Better mark jumps Ctrl-S and Shift-Up/Down
          limelight-vim # Focus helper
          commentnvim
          nvim-transparent
          splitjoin-vim # Better split/join with gS/gJ
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
          undowarn # warn for over-undo
          vim-colorschemes-forked
          vim-easytags
          vim-fugitive # git helper
          vim-gh-line
          vim-go
          vim-gutentags
          vim-illuminate # highlight word under cursor everywhere
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
