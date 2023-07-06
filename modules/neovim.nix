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
        rev = "f6a0f8387fbea5fbc2b78137444a9de4fdd02459";
        sha256 = "1qqd193mlgwrvdwhmcccwpr731a9z974k738wbx173lp7ln28k2z";
      };
    };
    yanky = buildVimPluginFrom2Nix {
      name = "yanky";
      src = pkgs.fetchFromGitHub {
        owner = "gbprod";
        repo = "yanky.nvim";
        rev = "b12561386a25645adb7504e0e6a8c5dc8b31e6da";
        sha256 = "0s2ssd1rg6bblbq50p2yx9vzip4vra4rsy6rsjkxlagw4y6qx4ss";
      };
    };
    leap = buildVimPluginFrom2Nix {
      name = "leap";
      src = pkgs.fetchFromGitHub {
        owner = "ggandor";
        repo = "leap.nvim";
        rev = "8facf2eb6a378fd7691dce8c8a7b2726823e2408";
        sha256 = "185zil8r41dz981qjmj241zri5iswfafqsx9racvsg87gcvysggn";
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
        rev = "176e85eeb63f1a5970d6b88f1725039d85ca0055";
        sha256 = "0y3zhv82hi8avxhmp1c9h0r17kfclwxphzyk7701f6wjky375ksw";
      };
    };
    telescope-file-browser = buildVimPluginFrom2Nix {
      name = "telescope-file-browser";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-telescope";
        repo = "telescope-file-browser.nvim";
        rev = "e03ff55962417b69c85ef41424079bb0580546ba";
        sha256 = "1agwrhwb6w0qpcgcmffibnip61g6dqjzmchngb1a9fwxqvzrgfll";
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
        rev = "a4a6d6b3f9e284e7f5c849619e06cd228cad8abd";
        sha256 = "1ychdiz76xrhras9fynzf5sb5cragv8lxyv3gpmjy8grb8znwyzq";
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
